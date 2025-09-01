#' LIMON Individual Networks (LOO) — robust
#'
#' Computes per-sample \emph{leave-one-out} (LIONESS-style) networks at each
#' timepoint. Supports backends \code{"spiec.easi"} (methods \code{"glasso"} or \code{"mb"}),
#' \code{"gcoda"}, \code{"magma"}, and \code{"sparcc"}. When \code{lambda.per.time} is
#' supplied (list of per-timepoint \eqn{\lambda^\*} from a prior NetInf run), SpiecEasi
#' refits each LOO with that fixed \eqn{\lambda^\*} using \code{pulsar.select = TRUE},
#' \code{nlambda = 1}, and extracts the optimal matrix via \code{getOpt*()}.
#'
#' @param Obj LIMON object with \code{$Corrected_Counts_Time}. If NetInf was run with SpiecEasi,
#'   \code{Obj$SpiecEasi_Time[[i]]} can serve as the full-network baseline at time \code{i}.
#' @param method Character. One of \code{"glasso"} (default), \code{"mb"}, \code{"sparcc"},
#'   \code{"magma"}, or \code{"gcoda"}.
#' @param sel.criterion Character. SpiecEasi selection criterion (\code{"stars"} default, or \code{"bstars"})
#'   used only when \code{lambda.per.time} is \code{NULL}.
#' @param lambda.min.ratio Numeric. Used by SpiecEasi/gCoda and as \eqn{\lambda} for MAGMA when
#'   \code{magma.select = FALSE} (default \code{0.1}). Ignored when \code{lambda.per.time} is given.
#' @param nlambda Integer. Number of \eqn{\lambda} values for SpiecEasi (default \code{10});
#'   set to \code{1} when \code{lambda.per.time} is given.
#' @param pulsar.select Logical. Enable Pulsar/StARS selection for SpiecEasi (default \code{TRUE}).
#' @param pulsar.params List. Passed to SpiecEasi \code{pulsar.params}. When \code{lambda.per.time}
#'   is given and this list is empty, defaults internally to \code{list(rep.num = 1, thresh = 0.1)} for speed.
#' @param icov.select Logical. SpiecEasi inverse-covariance selection flag (default \code{pulsar.select}).
#' @param icov.select.params List. Passed to SpiecEasi \code{icov.select.params} (default \code{pulsar.params}).
#' @param lambda.log Logical. Log-scaled \eqn{\lambda} path (default \code{TRUE}).
#' @param lambda.per.time Optional \emph{list} of fixed per-timepoint \eqn{\lambda^\*} (length equals
#'   number of timepoints), typically extracted via \code{get_spiec_lambdas_from_netinf()}.
#'
#' @details
#' \strong{Matrix types used internally:}
#' \itemize{
#'   \item \code{spiec.easi + glasso}: \emph{precision} via \code{SpiecEasi::getOptiCov()} (recommended).
#'   \item \code{spiec.easi + mb}: \emph{beta} via \code{symBeta(getOptBeta())}.
#'   \item \code{gcoda}: \emph{precision} (optimal inverse covariance).
#'   \item \code{magma}: \emph{precision} (\code{opt.icov}).
#'   \item \code{sparcc}: \emph{correlation}.
#' }
#' LIONESS reconstruction per sample \eqn{s} at time \eqn{t} is computed as
#' \deqn{G^{(s)}_t = n_t \, (G^{(\mathrm{all})}_t - G^{(-s)}_t) + G^{(-s)}_t,}
#' where \eqn{n_t} is the number of samples at time \eqn{t}, \eqn{G^{(\mathrm{all})}_t} is the
#' full fit, and \eqn{G^{(-s)}_t} is the fit with sample \eqn{s} removed.
#'
#' @return The input \code{Obj} with an additional slot:
#' \itemize{
#'   \item \code{$Individual_Networks}: a named list of per-sample matrices
#'         (entries named like \code{"<sample>_Time<i>"}), each matching the backend’s matrix type
#'         for the chosen \code{method}.
#' }
#'
#' @seealso \code{\link{LIMON_NetInf_Time}} for timepoint-level fits and
#'   \code{\link{get_spiec_lambdas_from_netinf}} to extract per-timepoint \eqn{\lambda^\*}.
#'
#' @examples
#' \dontrun{
#' ## After running NetInf with SpiecEasi glasso:
#' L_obj3 <- LIMON_NetInf_Time(Obj = L_obj2, model = "spiec.easi", method = "glasso")
#' lambda.per.time <- get_spiec_lambdas_from_netinf(L_obj3)
#'
#' ## Individual networks with fixed λ* (fast, consistent):
#' L_obj4 <- LIMON_IndNet(
#'   Obj = L_obj3,
#'   method = "glasso",
#'   lambda.per.time = lambda.per.time,
#'   nlambda = 1,
#'   pulsar.select = TRUE,
#'   pulsar.params = list(rep.num = 1, thresh = 0.1),
#'   icov.select = FALSE
#' )
#'
#' ## Alternative backends (no λ* concept):
#' L_obj4 <- LIMON_IndNet(Obj = L_obj3, method = "gcoda")
#' L_obj4 <- LIMON_IndNet(Obj = L_obj3, method = "magma", lambda.min.ratio = 0.1)
#' L_obj4 <- LIMON_IndNet(Obj = L_obj3, method = "sparcc")
#' }
#'
#' @importFrom SpiecEasi spiec.easi getOptiCov getOptBeta symBeta
#' @export

LIMON_IndNet <- function(
    Obj,
    method = "glasso",           # SpiecEasi glasso by default
    sel.criterion = "stars",
    lambda.min.ratio = 0.1,
    nlambda = 10,
    pulsar.select = TRUE,
    pulsar.params = list(),
    icov.select = pulsar.select,
    icov.select.params = pulsar.params,
    lambda.log = TRUE,
    lambda.per.time = NULL
) {
  
  # ---- Basic checks ----
  if (!is.list(Obj) || is.null(Obj$Corrected_Counts_Time) || !length(Obj$Corrected_Counts_Time)) {
    stop("Obj$Corrected_Counts_Time must be a non-empty list of count tables.")
  }
  if (!method %in% c("glasso","mb","sparcc","magma","gcoda")) {
    stop("method must be one of: 'glasso','mb','sparcc','magma','gcoda'.")
  }
  if (!is.null(lambda.per.time)) {
    # Make sure we have one λ per timepoint (your usage expects this)
    T <- length(Obj$Corrected_Counts_Time)
    if (length(lambda.per.time) != T) {
      stop(sprintf("lambda.per.time must have length %d (one λ per timepoint).", T))
    }
  }
  
  # ---- Helpers (for gcoda robustness) ----
  align_to_feats_safe <- function(X, feats) {
    X <- as.data.frame(X)
    miss <- setdiff(feats, colnames(X))
    if (length(miss)) X[miss] <- 0
    X <- X[, feats, drop = FALSE]
    X[] <- lapply(X, function(x) {
      if (is.list(x)) x <- unlist(x, recursive = TRUE, use.names = FALSE)
      if (is.factor(x)) x <- as.character(x)
      as.numeric(x)
    })
    M <- as.matrix(X); M[!is.finite(M)] <- 0; M
  }
  re_embed_sym_matrix <- function(mat, full_feats, fit_feats) {
    out <- matrix(0, length(full_feats), length(full_feats),
                  dimnames = list(full_feats, full_feats))
    if (!is.null(mat) && length(fit_feats)) out[fit_feats, fit_feats] <- mat
    out
  }
  safe_gcoda_fit <- function(X, feats_full, lambda.min.ratio, nlambda, ebic.gamma = 0.5) {
    keep <- colSums(X) > 0
    feats_fit <- feats_full[keep]
    if (sum(keep) < 2 || nrow(X) < 2) return(re_embed_sym_matrix(NULL, feats_full, character(0)))
    X_fit <- X[, keep, drop = FALSE]
    gc <- try({
      if (requireNamespace("gCoda", quietly = TRUE)) {
        gCoda::gcoda(x = X_fit, counts = TRUE,
                     lambda.min.ratio = lambda.min.ratio, nlambda = nlambda, ebic.gamma = ebic.gamma)
      } else {
        gcoda(x = X_fit, counts = TRUE,
              lambda.min.ratio = lambda.min.ratio, nlambda = nlambda, ebic.gamma = ebic.gamma)
      }
    }, silent = TRUE)
    if (inherits(gc, "try-error") || is.null(gc$opt.icov) || !is.matrix(gc$opt.icov)) {
      return(re_embed_sym_matrix(NULL, feats_full, character(0)))
    }
    est <- gc$opt.icov; dimnames(est) <- list(feats_fit, feats_fit)
    re_embed_sym_matrix(est, feats_full, feats_fit)
  }
  
  # ---- Main ----
  Individual_Networks <- list()
  n_time <- length(Obj$Corrected_Counts_Time)
  pb <- utils::txtProgressBar(min = 0, max = n_time, style = 3)
  on.exit(close(pb), add = TRUE)
  
  for (i in seq_len(n_time)) {
    count_table <- Obj$Corrected_Counts_Time[[i]]
    if (is.null(rownames(count_table))) rownames(count_table) <- paste0("sample", seq_len(nrow(count_table)))
    nsamples <- nrow(count_table)
    feats <- colnames(count_table)
    if (is.null(feats) || !length(feats)) stop(sprintf("No feature names at timepoint %d.", i))
    
    # --- Full-network baseline ---
    if (identical(method, "sparcc")) {
      s <- SpiecEasi::sparcc(count_table)
      net_all <- as.matrix(s$Cor)
      dimnames(net_all) <- list(feats, feats)
    } else if (identical(method, "magma")) {
      if (!requireNamespace("rMAGMA", quietly = TRUE)) stop("Install 'rMAGMA' for method='magma'.")
      X_all <- align_to_feats_safe(count_table, feats)
      mag <- rMAGMA::magma(data = X_all, distrib = "ZINB", method = "glasso",
                           magma.select = FALSE, lambda = lambda.min.ratio)
      net_all <- mag$opt.icov; if (is.null(net_all)) stop(sprintf("MAGMA failed at time %d.", i))
      dimnames(net_all) <- list(feats, feats)
    } else if (identical(method, "gcoda")) {
      X_all <- align_to_feats_safe(count_table, feats)
      net_all <- safe_gcoda_fit(X_all, feats, lambda.min.ratio, nlambda, ebic.gamma = 0.5)
    } else { # SpiecEasi ("glasso" or "mb")
      # Prefer the *NetInf* fit as baseline, like your earlier working code
      if (!is.null(Obj$SpiecEasi_Time) && length(Obj$SpiecEasi_Time) >= i && !is.null(Obj$SpiecEasi_Time[[i]])) {
        sp_obj <- Obj$SpiecEasi_Time[[i]]
        net_all <- if (identical(method, "glasso"))
          as.matrix(SpiecEasi::getOptiCov(sp_obj)) else as.matrix(SpiecEasi::getOptBeta(sp_obj))
      } else if (!is.null(lambda.per.time)) {
        # If baseline not present, refit once on full data using your precomputed λ + selection TRUE
        fit_all <- SpiecEasi::spiec.easi(
          data = as.matrix(count_table),
          method = method,
          lambda = lambda.per.time[[i]],
          pulsar.select = TRUE,
          pulsar.params = if (length(pulsar.params)) pulsar.params else list(rep.num = 1, thresh = 0.1),
          icov.select = FALSE,
          nlambda = 1,
          verbose = FALSE
        )
        net_all <- if (identical(method, "glasso"))
          as.matrix(SpiecEasi::getOptiCov(fit_all)) else as.matrix(SpiecEasi::getOptBeta(fit_all))
      } else {
        # Regular selection path
        fit_all <- SpiecEasi::spiec.easi(
          data = as.matrix(count_table),
          method = method,
          sel.criterion = sel.criterion,
          lambda.min.ratio = lambda.min.ratio,
          nlambda = nlambda,
          pulsar.select = pulsar.select,
          pulsar.params = pulsar.params,
          icov.select = icov.select,
          icov.select.params = icov.select.params,
          lambda.log = lambda.log,
          verbose = FALSE
        )
        net_all <- if (identical(method, "glasso"))
          as.matrix(SpiecEasi::getOptiCov(fit_all)) else as.matrix(SpiecEasi::getOptBeta(fit_all))
      }
      dimnames(net_all) <- list(feats, feats)
    }
    
    # --- LOO per-sample ---
    for (j in seq_len(nsamples)) {
      X_minus <- count_table[-j, , drop = FALSE]
      
      if (identical(method, "sparcc")) {
        net_minus_j <- as.matrix(SpiecEasi::sparcc(X_minus)$Cor)
      } else if (identical(method, "magma")) {
        if (!requireNamespace("rMAGMA", quietly = TRUE)) stop("Install 'rMAGMA' for method='magma'.")
        Xm <- align_to_feats_safe(X_minus, feats)
        magj <- rMAGMA::magma(data = Xm, distrib = "ZINB", method = "glasso",
                              magma.select = FALSE, lambda = lambda.min.ratio)
        net_minus_j <- magj$opt.icov; if (is.null(net_minus_j)) stop(sprintf("MAGMA LOO failed at time %d.", i))
      } else if (identical(method, "gcoda")) {
        Xm <- align_to_feats_safe(X_minus, feats)
        net_minus_j <- safe_gcoda_fit(Xm, feats, lambda.min.ratio, nlambda, ebic.gamma = 0.5)
      } else { # SpiecEasi LOO with your proven precomputed-λ flow (or selection)
        if (!is.null(lambda.per.time)) {
          fit_j <- SpiecEasi::spiec.easi(
            data = as.matrix(X_minus),
            method = method,
            lambda = lambda.per.time[[i]],
            pulsar.select = TRUE,
            pulsar.params = if (length(pulsar.params)) pulsar.params else list(rep.num = 1, thresh = 0.1),
            icov.select = FALSE,
            nlambda = 1,
            verbose = FALSE
          )
          net_minus_j <- if (identical(method, "glasso"))
            as.matrix(SpiecEasi::getOptiCov(fit_j)) else as.matrix(SpiecEasi::getOptBeta(fit_j))
        } else {
          fit_j <- SpiecEasi::spiec.easi(
            data = as.matrix(X_minus),
            method = method,
            sel.criterion = sel.criterion,
            lambda.min.ratio = lambda.min.ratio,
            nlambda = nlambda,
            pulsar.select = pulsar.select,
            pulsar.params = pulsar.params,
            icov.select = icov.select,
            icov.select.params = icov.select.params,
            lambda.log = lambda.log,
            verbose = FALSE
          )
          net_minus_j <- if (identical(method, "glasso"))
            as.matrix(SpiecEasi::getOptiCov(fit_j)) else as.matrix(SpiecEasi::getOptBeta(fit_j))
        }
      }
      
      dimnames(net_minus_j) <- list(feats, feats)
      
      # LIONESS-style individual network
      net_individual <- nsamples * (net_all - net_minus_j) + net_minus_j
      colnames(net_individual) <- rownames(net_individual) <- feats
      
      net_name <- paste0(rownames(count_table)[j], "_Time", i)
      Individual_Networks[[net_name]] <- net_individual
    }
    
    utils::setTxtProgressBar(pb, i)
  }
  
  Obj$Individual_Networks <- Individual_Networks
  Obj
}

## Extract per-timepoint λ* from *NetInf_Time*

get_spiec_lambdas_from_netinf <- function(Obj) {
  fits <- Obj$NetInf_Time
  if (is.null(fits) || !length(fits)) stop("Obj$NetInf_Time is missing or empty.")
  T <- length(Obj$Corrected_Counts_Time)
  
  # Helper to safely get a lambda from a spiec.easi fit
  safe_opt_lambda <- function(fit) {
    lam <- fit$lambda
    if (is.null(lam) || !length(lam)) return(NA_real_)
    idx <- if (!is.null(fit$select$stars$opt.index)) {
      fit$select$stars$opt.index
    } else if (!is.null(fit$select$bstars$opt.index)) {
      fit$select$bstars$opt.index
    } else {
      NA_integer_
    }
    # clamp to bounds if NA/out-of-range
    if (is.na(idx) || idx < 1L || idx > length(lam)) {
      warning("StARS opt.index missing/outside path; using boundary lambda for one timepoint.")
      idx <- max(1L, min(length(lam), ifelse(is.na(idx), length(lam), as.integer(idx))))
    }
    lam[idx]
  }
  
  # Build a strict list of length T with one numeric per timepoint
  lambda.per.time <- vector("list", T)
  for (i in seq_len(T)) {
    fit <- fits[[paste0("Net_", i)]]
    # If you stored raw fits (not named), also allow numeric index access:
    if (is.null(fit) && length(fits) >= i) fit <- fits[[i]]
    
    # Non-SpiecEasi models won’t have lambda/select slots
    if (is.null(fit) || is.null(fit$select) || is.null(fit$lambda)) {
      stop(sprintf("NetInf at timepoint %d is not a SpiecEasi fit (or lacks lambda/select).", i))
    }
    
    lambda.per.time[[i]] <- safe_opt_lambda(fit)
  }
  lambda.per.time
}
