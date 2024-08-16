#' Export Edge list for cytoscape
#'
#' @param Obj LIMON Object from running LIMON_Edges_Networks()
#'
#' @return Edge_Table written to Global Environment with Sources, Sinks and Edge Weights
#' @export
LIMON_Cyto_Export <- function(Obj){
  edge_tables <- Obj[["Edge_Table"]]

  #Create dataframes for each edge table by timepoint
  for (i in seq_along(edge_tables)) {
    table_name <- names(edge_tables)[i]
    table_data <- edge_tables[[i]]
    assign(table_name, table_data, envir = .GlobalEnv)
  }
}
