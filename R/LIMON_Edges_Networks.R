#' Get edge table and printed network from LIMON after Network inference per time
#'
#' @param Obj LIMON object from LIMON_Netnf_Time()
#' @param threshold Numeric value of minimum value edges must be. Default is 0.2. Below that threshold will be converted to 0
#' @param vertex.size Numeric value for vertex size for network plotting. Default = 3
#' @param vertex.label.cex Numeric value for vertex label for network plotting. Default = 8
#' @param vertex.label.color Node label color. Default "black"
#'
#' @return A LIMON Object with Edge_Table and Network_Graphs added to it. Edge_Table: List with Edge_Table_i for each Time point i. Columns are sources and sinks (taxa rows and columns from covariance matrix) and Edge_weight - value from covariance matrix. Network_Graphs: A Network_Graph_i igraph per time point i. Prints a graph per time point
#' @export
LIMON_Edges_Networks <- function (Obj, threshold = 0.2, vertex.size = 3, vertex.label.cex = 8,
                                  vertex.label.color = "black")
{
  Edge_Table <- list()
  for (i in seq_along(Obj[["CovMatrix_Time"]])) {
    cov_matrix <- Obj[["CovMatrix_Time"]][[i]]
    edge_table_name <- paste0("Edge_Table_", i)
    diagonal_indices <- 1:nrow(cov_matrix)
    cov_matrix[cbind(diagonal_indices, diagonal_indices)] <- 0
    cov_matrix[lower.tri(cov_matrix)] <- 0
    cov_matrix[abs(cov_matrix) < threshold] <- 0
    adj <- as.data.frame(as.table(cov_matrix))
    colnames(adj) <- c("Source", "Sink", "Edge_weight")
    adj <- adj[adj$Edge_weight != 0, ]
    Edge_Table[[edge_table_name]] <- adj
  }
  Network_Graphs <- list()
  for (i in seq_along(Obj[["CovMatrix_Time"]])) {
    cov_matrix <- Obj[["CovMatrix_Time"]][[i]]
    diagonal_indices <- 1:nrow(cov_matrix)
    cov_matrix[cbind(diagonal_indices, diagonal_indices)] <- 0
    cov_matrix[abs(cov_matrix) < threshold] <- 0
    adj_matrix <- sign(cov_matrix)
    graph <- graph_from_adjacency_matrix(abs(adj_matrix), mode = "undirected")
    edge_weights <- abs(cov_matrix)
    normalized_edge_weights <- pmax(0.1, pmin(5, edge_weights))

    # Create an empty vector to store edge colors
    edge_colors <- rep(NA, ecount(graph))

    # Identify the non-zero edges and assign colors
    non_zero_edges <- which(adj_matrix != 0)
    edge_colors[non_zero_edges] <- ifelse(cov_matrix[non_zero_edges] > 0,
                                          "blue", "red")
    edge_colors <- edge_colors[!is.na(edge_colors)]
    isolated_nodes <- which(degree(graph) == 0)
    graph <- delete.vertices(graph, isolated_nodes)
    nodelab <- rownames(cov_matrix)

    plot(graph, layout = layout_randomly(graph), edge.color = edge_colors,
         edge.width = normalized_edge_weights * 3, vertex_labels = nodelab,
         vertex.size = 3, vertex.label.cex = 0.8, vertex.label.color = "black",
         main = paste0("Network Time", i))
    Graphs_name <- paste0("Network_Time", i)
    Network_Graphs[[Graphs_name]] <- graph
  }
  Obj[["Edge_Table"]] <- Edge_Table
  Obj[["Network_Graphs"]] <- Network_Graphs
  Obj
}
