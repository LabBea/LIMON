#' LIMON Network Inference Over Time (robust)
#'
#' Fits longitudinal microbial association networks per timepoint using one of
#' \code{"spiec.easi"}, \code{"gcoda"}, \code{"magma"}, \code{"sparcc"}, or \code{"onenet"}.
#' Outputs per-timepoint matrices normalized to a single enforced type
#' (default: \emph{precision}) and optional pairwise timepoint differences.
#'
#' @param Obj List containing \code{Corrected_Counts_Time}: list of count tables (rows = samples, cols = taxa/features).
#' @param model Character. One of \code{"spiec.easi"}, \code{"gcoda"}, \code{"magma"}, \code{"sparcc"}, \code{"onenet"} (default: \code{"spiec.easi"}).
#' @param method Character. SpiecEasi method if \code{model = "spiec.easi"}; one of \code{"glasso"} or \code{"mb"} (default: \code{"glasso"}). Ignored by other models.
#' @param sel.criterion Character. SpiecEasi selection criterion (default: \code{"stars"}).
#' @param lambda.min.ratio Numeric. Used by SpiecEasi/gCoda and as \eqn{\lambda} for MAGMA when \code{magma.select = FALSE} (default: \code{0.1}).
#' @param nlambda Integer. Number of \eqn{\lambda} values where applicable (default: \code{10}).
#' @param pulsar.select Logical. Enable SpiecEasi Pulsar/StARS selection (default: \code{TRUE}).
#' @param pulsar.params List. Passed to SpiecEasi \code{pulsar.params} (default: \code{list()}).
#' @param icov.select Logical. SpiecEasi inverse-covariance selection (default: \code{pulsar.select}).
#' @param icov.select.params List. Passed to SpiecEasi \code{icov.select.params} (default: \code{pulsar.params}).
#' @param lambda.log Logical. Log-scaled \eqn{\lambda} path in SpiecEasi (default: \code{TRUE}).
#' @param matrix_target Character. Enforce one matrix type across timepoints and diffs;
#'   one of \code{"precision"}, \code{"correlation"}, \code{"adjacency"}, \code{"beta"} (default: \code{"precision"}).
#' @param diff_on Logical. If \code{TRUE}, compute pairwise differences between timepoints (default: \code{TRUE}).
#' @param feature_set Character. Either \code{"intersect"} (keep features present in all timepoints) or
#'   \code{"union"} (union; missing features filled with zeros) (default: \code{"intersect"}).
#' @param seed Optional integer for reproducibility (default: \code{NULL}).
#' @param keep_onenet_details Logical. Keep heavy OneNet objects (default: \code{FALSE}).
#' @param onenet_threshold Numeric in [0,1]. Threshold on mean stability for OneNet adjacency (default: \code{0.6}).
#' @param onenet_rep.num Integer. Number of repetitions for OneNet (default: \code{10}).
#' @param onenet_mean.stability Numeric in [0,1]. Target mean stability for OneNet (default: \code{0.8}).
#'
#' @details
#' \strong{Matrix types by backend (before enforcing \code{matrix_target}):}
#' \itemize{
#'   \item \code{spiec.easi + glasso}: \emph{precision} (via \code{SpiecEasi::getOptiCov()}).
#'   \item \code{spiec.easi + mb}: \emph{beta} (via \code{symBeta(getOptBeta())}); not a precision matrix.
#'   \item \code{gcoda}: \emph{precision} (optimal inverse covariance).
#'   \item \code{magma}: \emph{precision} (ZINB + glasso; \code{opt.icov}).
#'   \item \code{sparcc}: \emph{correlation}.
#'   \item \code{onenet}: \emph{adjacency} via stability thresholding.
#' }
#' The function converts or selects outputs to match \code{matrix_target} when possible; for
#' example, \code{"glasso"} returns precision by default for consistency with \code{gcoda}/\code{magma}.
#'
#' @return The input \code{Obj} with additional slots:
#' \itemize{
#'   \item \code{NetInf_Time}: list of per-timepoint fit objects (may be \code{NULL} for lightweight modes).
#'   \item \code{CovMatrix_Time}: named list of matrices (\code{Matrix_i}) all of type \code{matrix_target};
#'         each matrix has attributes \code{matrix_type} and \code{model}.
#'   \item \code{CovMatrix_Diff}: named list of pairwise differences (\code{Matrix_Diff_ji}) if \code{diff_on = TRUE}.
#' }
#'
#' @seealso \code{\link{LIMON_IndNet}} for LIONESS-style individual (LOO) networks with optional precomputed \eqn{\lambda^\*}.
#'
#' @examples
#' \dontrun{
#' ## SpiecEasi glasso, precision (default)
#' L_obj3 <- LIMON_NetInf_Time(
#'   Obj = L_obj2, model = "spiec.easi", method = "glasso",
#'   matrix_target = "precision", seed = 123
#' )
#'
#' ## Extract λ* per timepoint and run individual networks (see LIMON_IndNet docs)
#' lambda.per.time <- get_spiec_lambdas_from_netinf(L_obj3)
#' L_obj4 <- LIMON_IndNet(Obj = L_obj3, method = "glasso",
#'                        lambda.per.time = lambda.per.time, nlambda = 1,
#'                        pulsar.select = TRUE, pulsar.params = list(rep.num=1, thresh=0.1),
#'                        icov.select = FALSE)
#' }
#'
#' @importFrom SpiecEasi spiec.easi getOptiCov getOptCov getOptBeta symBeta
#' @export

LIMON_NetInf_Time <- function(
    Obj,
    model  = "spiec.easi",                 # was "gcoda"
    method = "glasso",                     # keep glasso for SpiecEasi
    sel.criterion = "stars",
    lambda.min.ratio = 0.1,
    nlambda = 10,
    pulsar.select = TRUE,
    pulsar.params = list(),
    icov.select = pulsar.select,
    icov.select.params = pulsar.params,
    lambda.log = TRUE,
    matrix_target = c("precision", "correlation", "adjacency", "beta"),  # default to "precision" below
    diff_on = TRUE,
    feature_set = c("intersect", "union"),
    seed = NULL,
    keep_onenet_details = FALSE,
    onenet_threshold = 0.6,
    onenet_rep.num = 10,
    onenet_mean.stability = 0.8
)  {
  
  ## ---- Arg checks ----
  matrix_target <- match.arg(matrix_target)
  feature_set   <- match.arg(feature_set)
  
  if (!is.list(Obj) || is.null(Obj[["Corrected_Counts_Time"]]) ||
      !length(Obj[["Corrected_Counts_Time"]])) {
    stop("Obj[['Corrected_Counts_Time']] must be a non-empty list of count tables.")
  }
  
  if (model == "magma" && !requireNamespace("rMAGMA", quietly = TRUE)) {
    stop("Package 'rMAGMA' not installed. Please install rMAGMA.")
  }
  if (model == "gcoda" && !exists("gcoda")) {
    # Prefer namespace check if function is namespaced; fall back to existence
    if (!requireNamespace("gCoda", quietly = TRUE) && !exists("gcoda", mode = "function")) {
      stop("Function 'gcoda()' not available. Please install/load package that provides gcoda().")
    }
  }
  if (model == "spiec.easi" && !method %in% c("glasso", "mb")) {
    stop("For model = 'spiec.easi', 'method' must be one of 'glasso' or 'mb'.")
  }
  
  if (!is.null(seed)) set.seed(seed)
  
  ## ---- Helper: edge df -> adjacency ----
  vector_to_adjmat_from_df <- function(aggreg_df, node_names,
                                       score_column = "mean", threshold = 0.6) {
    p <- length(node_names)
    adj_mat <- matrix(0, nrow = p, ncol = p,
                      dimnames = list(node_names, node_names))
    if (nrow(aggreg_df) == 0) return(adj_mat)
    for (k in seq_len(nrow(aggreg_df))) {
      edge <- aggreg_df$edge_name[k]
      val  <- suppressWarnings(aggreg_df[[score_column]][k])
      if (!is.na(val) && val >= threshold) {
        nodes <- strsplit(edge, "--", fixed = TRUE)[[1]]
        if (length(nodes) == 2) {
          node_a <- trimws(nodes[1]); node_b <- trimws(nodes[2])
          if (node_a %in% node_names && node_b %in% node_names) {
            adj_mat[node_a, node_b] <- 1
            adj_mat[node_b, node_a] <- 1
          }
        }
      }
    }
    adj_mat
  }
  
  ## ---- Feature alignment (union/intersect) ----
  feature_lists <- lapply(Obj[["Corrected_Counts_Time"]], function(x) colnames(x))
  if (any(vapply(feature_lists, is.null, logical(1)))) {
    stop("All count tables must have column names (features).")
  }
  all_feats    <- Reduce(union, feature_lists)
  common_feats <- Reduce(intersect, feature_lists)
  target_feats <- if (feature_set == "intersect") common_feats else all_feats
  if (!length(target_feats)) {
    stop("No overlapping features across timepoints; cannot proceed.")
  }
  
  ## ---- Coercion helper: to numeric, aligned matrix ----
  to_numeric_matrix <- function(df) {
    df <- as.data.frame(df)
    # Add missing columns if using union, fill zeros
    missing <- setdiff(target_feats, colnames(df))
    if (length(missing)) df[missing] <- 0
    # Keep only target features in desired order
    df <- df[, target_feats, drop = FALSE]
    # Coerce columns to numeric safely
    df[] <- lapply(df, function(x) {
      if (is.list(x)) x <- unlist(x, recursive = TRUE, use.names = FALSE)
      if (is.factor(x)) x <- as.character(x)
      as.numeric(x)
    })
    if (!all(vapply(df, is.numeric, TRUE))) {
      stop("Non-numeric values present after coercion.")
    }
    as.matrix(df)
  }
  
  ## ---- Type normalization (enforcement only) ----
  tag_matrix <- function(mat, type, model_name) {
    attr(mat, "matrix_type") <- type
    attr(mat, "model") <- model_name
    mat
  }
  enforce_type <- function(type_produced, model_name) {
    if (!identical(type_produced, matrix_target)) {
      stop(sprintf(
        "Model '%s' produced type '%s' but matrix_target='%s'. Conversion not implemented.",
        model_name, type_produced, matrix_target
      ))
    }
  }
  
  ## ---- Storage ----
  CovMatrix_Time <- list()
  NetInf_Time    <- list()
  CovMatrix_Diff <- list()
  
  ## ---- Progress bar ----
  pb <- txtProgressBar(min = 0, max = length(Obj[["Corrected_Counts_Time"]]), style = 3)
  on.exit(close(pb), add = TRUE)
  
  ## ---- Main loop ----
  for (i in seq_along(Obj[["Corrected_Counts_Time"]])) {
    count_table <- Obj[["Corrected_Counts_Time"]][[i]]
    X <- to_numeric_matrix(count_table)
    
    network_name   <- paste0("Net_", i)
    cov_matrix_name <- paste0("Matrix_", i)
    
    est_mat <- NULL
    net_obj <- NULL
    produced_type <- NULL
    
    if (model == "sparcc") {
      s <- SpiecEasi::sparcc(X)
      est_mat <- as.matrix(s$Cor)
      colnames(est_mat) <- rownames(est_mat) <- colnames(X)
      produced_type <- "correlation"
      enforce_type(produced_type, "sparcc")
      est_mat <- tag_matrix(est_mat, produced_type, "sparcc")
      net_obj <- s
      
    } else if (model == "magma") {
      mag <- rMAGMA::magma(
        data = X,
        distrib = "ZINB",
        method = "glasso",
        magma.select = FALSE,
        lambda = lambda.min.ratio
      )
      est_mat <- mag$opt.icov
      if (is.null(est_mat) || !is.matrix(est_mat)) stop("MAGMA did not return a valid precision matrix.")
      colnames(est_mat) <- rownames(est_mat) <- colnames(X)
      produced_type <- "precision"
      enforce_type(produced_type, "magma")
      est_mat <- tag_matrix(est_mat, produced_type, "magma")
      net_obj <- mag
      if (!keep_onenet_details && "inference" %in% names(net_obj)) net_obj$inference <- NULL
      
    } else if (model == "gcoda") {
      g <- gcoda(
        x = X,
        counts = TRUE,
        lambda.min.ratio = lambda.min.ratio,
        nlambda = nlambda,
        ebic.gamma = 0.5
      )
      if (is.null(g$opt.icov)) stop(sprintf("gCoda failed at timepoint %d", i))
      est_mat <- g$opt.icov
      colnames(est_mat) <- rownames(est_mat) <- colnames(X)
      produced_type <- "precision"
      enforce_type(produced_type, "gcoda")
      est_mat <- tag_matrix(est_mat, produced_type, "gcoda")
      net_obj <- g
      
    } else if (model == "onenet") {
      inf <- OneNet::all_inferences_new(
        data = X,
        rep.num = onenet_rep.num,
        methods = c("PLNnetwork", "SpiecEasi", "gCoda", "EMtree", "Magma", "SPRING", "ZiLN"),
        fast = FALSE
      )
      ada   <- OneNet::adapt_mean_stability(inf, mean.stability = onenet_mean.stability)
      freqs <- ada$freqs
      p     <- ncol(X)
      idx   <- which(upper.tri(matrix(0, p, p)), arr.ind = TRUE)
      edge_names <- paste(colnames(X)[idx[, 1]], "--", colnames(X)[idx[, 2]])
      aggreg     <- OneNet::compute_aggreg_measures(freqs)
      df_edges   <- data.frame(edge_name = edge_names, aggreg, row.names = NULL)
      adj        <- vector_to_adjmat_from_df(df_edges, colnames(X),
                                             score_column = "mean", threshold = onenet_threshold)
      est_mat <- adj
      produced_type <- "adjacency"
      enforce_type(produced_type, "onenet")
      est_mat <- tag_matrix(est_mat, produced_type, "onenet")
      net_obj <- if (keep_onenet_details) list(edge_summary = df_edges, adapted_frequencies = freqs) else NULL
      
    } else if (model == "spiec.easi") {
      fit <- SpiecEasi::spiec.easi(
        X,
        method = method,
        sel.criterion = sel.criterion,
        lambda.min.ratio = lambda.min.ratio,
        nlambda = nlambda,
        pulsar.select = pulsar.select,
        pulsar.params = pulsar.params,
        icov.select = icov.select,
        icov.select.params = icov.select.params,
        lambda.log = lambda.log
      )
      if (method == "glasso") {
        est_mat <- as.matrix(SpiecEasi::getOptiCov(fit))  
        produced_type <- "precision"
      } else {
        est_mat <- as.matrix(SpiecEasi::getOptBeta(fit)) # β (neighborhood selection)
        produced_type <- "beta"
      }
      colnames(est_mat) <- rownames(est_mat) <- colnames(X)
      enforce_type(produced_type, "spiec.easi")
      est_mat <- tag_matrix(est_mat, produced_type, "spiec.easi")
      net_obj <- fit
      
    } else {
      stop("Unknown 'model'. Use one of: 'gcoda','magma','sparcc','onenet','spiec.easi'.")
    }
    
    NetInf_Time[[network_name]]      <- net_obj
    CovMatrix_Time[[cov_matrix_name]] <- est_mat
    setTxtProgressBar(pb, i)
  }
  
  ## ---- Differences (safe) ----
  if (diff_on) {
    types <- vapply(CovMatrix_Time, function(m) attr(m, "matrix_type"), character(1))
    if (!all(types == matrix_target)) {
      stop(sprintf(
        "Cannot compute differences: matrix types differ across timepoints (%s).",
        paste(unique(types), collapse = ", ")
      ))
    }
    # Feature alignment was enforced earlier; names/order match target_feats
    N <- length(CovMatrix_Time)
    if (N >= 2) {
      for (i in 1:(N - 1)) {
        for (j in (i + 1):N) {
          A <- CovMatrix_Time[[paste0("Matrix_", j)]]
          B <- CovMatrix_Time[[paste0("Matrix_", i)]]
          CovMatrix_Diff[[paste0("Matrix_Diff_", j, i)]] <- A - B
        }
      }
    }
  }
  
  ## ---- Return enriched object ----
  Obj[["NetInf_Time"]]   <- NetInf_Time
  Obj[["CovMatrix_Time"]] <- CovMatrix_Time
  Obj[["CovMatrix_Diff"]] <- CovMatrix_Diff
  Obj
}
