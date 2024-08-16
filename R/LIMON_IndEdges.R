#' Extract edge table for Individual networks
#'
#' This function is the follow up to LIMON_IndNet(). After inferring individual networks (networks per sample), this function will extract the edge list for each unique pair of interactions.
#'
#' @param Obj LIMON object from LIMON_IndNet()
#' @param threshold (Optional) absolute value of the minimum edge weight. [Default] = 0.2
#'
#' @return Returns a list of individual edge tables store in Individual_Edge_Table and a merged version with the Sample data in Merged_Edge_Table. This can be used for further analysis of edge changes overtime.
#' @export
#'
LIMON_IndEdges <- function (Obj, threshold = 0.2)
{
  Individual_Edge_Table <- list()
  for (i in seq_along(Obj[["Individual_Networks"]])) {
    cov_matrix <- Obj[["Individual_Networks"]][[i]]
    network_name <- names(Obj[["Individual_Networks"]][i])
    edge_table_name <- paste0("Edge_Table_", network_name)
    diagonal_indices <- 1:nrow(cov_matrix)
    cov_matrix[cbind(diagonal_indices, diagonal_indices)] <- 0
    cov_matrix[lower.tri(cov_matrix)] <- 0
    cov_matrix[abs(cov_matrix) < threshold] <- 0
    adj <- as.data.frame(as.table(cov_matrix))
    colnames(adj) <- c("Source", "Sink", "Edge_weight")
    adj <- adj[adj$Edge_weight != 0, ]
    adj$SampleID <- network_name
    Individual_Edge_Table[[edge_table_name]] <- adj
  }
  Merged_Edge_Table <- do.call(rbind, Individual_Edge_Table)
  SampleData2 <- Obj[["SampleData"]]
  SampleData2 <- rownames_to_column(SampleData2, "SampleID")
  Merged_Edge2 <- merge(SampleData2, Merged_Edge_Table, by = "SampleID")
  Merged_Edge2$Interaction <- paste(Merged_Edge2$Source, Merged_Edge2$Sink,
                                    sep = "-")
  Obj[["Individual_Edge_Table"]] <- Individual_Edge_Table
  Obj[["Merged_Edge_Table"]] <- Merged_Edge2
  Obj
}
