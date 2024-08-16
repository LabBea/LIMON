#' Individual Network Inferences
#'
#' # Function to perform network inferences following method in lionessR - https://github.com/mararie/lionessR. Note: Consider using the same methods and parameters as in LIMON_NetInf_Time(). See the \pkg{SpiecEasi} documentation for more details.
#'
#' @param Obj LIMON Object from LIMON_NetInf_Time()
#' @param method Default "glasso". "mb" other option from SpiecEasi
#' @param sel.criterion Method for model selection. Either 'stars' [default] or 'bstars' (Bounded StARS)
#' @param lambda.min.ratio Scaling factor that will set the minimum lambda (sparsity) parameter
#' @param nlambda sparsity parameter (see SpiecEasi for more details)
#' @param pulsar.select Default TRUE
#' @param pulsar.params Default empty list()
#' @param icov.select Default "pulsar.select"
#' @param icov.select.params Default "pulsar.params"
#' @param lambda.log Default TRUE
#'
#' @return LIMON object with individual networks per sample stored in Individual_Networks by sample name
#' @export
#'
LIMON_IndNet <- function(Obj, method,
                         sel.criterion,
                         lambda.min.ratio,
                         nlambda ,
                         pulsar.select=TRUE,
                         pulsar.params=list(),
                         icov.select = pulsar.select,
                         icov.select.params = pulsar.params,
                         lambda.log = TRUE){

  Individual_Networks <- list()

  # Initialize the progress bar
  pb <- txtProgressBar(min = 0, max = length(Obj[["SpiecEasi_Time"]]), style = 3)

  for (i in seq_along(Obj[["SpiecEasi_Time"]])) {
    net_all <- as.matrix(getOptCov(Obj[["SpiecEasi_Time"]][[i]]))
    count_table <- Obj[["Corrected_Counts_Time"]][[i]]


    # Individualized Networks
    for (j in 1:nrow(count_table)) {
      samplename <- rownames(count_table[j, ])
      nsamples <- nrow(count_table)
      net_single <- spiec.easi(data = as.matrix(count_table[-j, ]), method = method, sel.criterion = sel.criterion,
                            lambda.min.ratio = lambda.min.ratio, nlambda = nlambda,
                            pulsar.select = pulsar.select, pulsar.params = pulsar.params,
                            icov.select = icov.select, icov.select.params = icov.select.params,
                            lambda.log = lambda.log)
      net_single_cov <- as.matrix(getOptCov(net_single))
      net_name <- samplename
      Individual_Networks[[net_name]] <- nsamples * (net_all -
                                                       net_single_cov) + net_single_cov
      colnames(Individual_Networks[[net_name]]) <- rownames(Individual_Networks[[net_name]]) <- colnames(count_table)
    }
  }

  # Update the progress bar
  setTxtProgressBar(pb, i)

  Obj[["Individual_Networks"]] <- Individual_Networks
  Obj
}
