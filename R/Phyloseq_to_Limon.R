#' Phyloseq to LIMON
#'
#' Create a formatted objects to run LIMON from a Phyloseq object
#'
#' @param ps_object a phyloseq object
#'
#' @returns Returns a LIMON Object with a Count and SampleData table in the correct format
#'
#' @export
#'
phyloseq_to_LIMON_Obj <- function(ps_object){
  list(Counts = as.data.frame(ps_object@otu_table),
       SampleData =ps_object@sam_data)
}
