#' Get graph network and edge table for difference between visits
#'
#' @param Obj LIMON Object after performing LIMON_DistrFit()
#' @param threshold Numeric value of minimum value edges must be. Default is 0.2. Below that threshold will be converted to 0
#' @param vertex.size Numeric value for vertex size for network plotting. Default = 3
#' @param vertex.label.cex Numeric value for vertex label for network plotting. Default = 8
#' @param vertex.label.color Node label color. Default "black"
#'
#' @return A LIMON Object with DiffEdge_Table and Diff_Network added to it. DiffEdge_Table: List with DiffEdge_Table_i from CovMatrix_Diff_ji. Columns are sources and sinks (taxa rows and columns from covariance matrix) and Edge_weight - value from covariance matrix. Diff_Networks: A Network_Graph_ji igraph per difference in time points CovMatrix_Diff_ji. Prints a graph per time point
#' @export
LIMON_Diff_Networks <- function(Obj, threshold = 0.2,
                                vertex.size = 3,
                                vertex.label.cex = 8,
                                vertex.label.color = "black"){

  #Part 1: Create edge list tables
  #########################################################
  #empty list to store edge tables in
  DiffEdge_Table <- list()

  # Pull each covariance matrix
  for (i in seq_along(Obj[["CovMatrix_Diff"]])) {
    cov_matrix <- Obj[["CovMatrix_Diff"]][[i]]

    # names for the edges table
    edge_table_name <- paste0("Edge_Table_", i)

    # Convert adjacency matrix to a data frame
    #convert diagonal elements to 0
    diagonal_indices <- 1:nrow(cov_matrix)
    cov_matrix[cbind(diagonal_indices, diagonal_indices)] <- 0
    #convert lower triangle to 0 so you dont pull redundant combos
    cov_matrix[lower.tri(cov_matrix)] <- 0

    # Apply threshold to absolute values of edges
    cov_matrix[abs(cov_matrix) < threshold] <- 0

    adj <- as.data.frame(as.table(cov_matrix))
    colnames(adj) <- c("Source", "Sink", "Edge_weight")


    # Filter out 0 edges
    adj <- adj[adj$Edge_weight != 0, ]

    DiffEdge_Table[[edge_table_name]] <- adj
  }

  #Part 2: Create igraph objects per visit
  #########################################################
  #empty list to store edge tables in
  Diff_Networks <- list()

  # Pull each covariance matrix
  for (i in seq_along(Obj[["CovMatrix_Diff"]])) {
    cov_matrix <- Obj[["CovMatrix_Diff"]][[i]]

    #convert diagonal elements to 0
    diagonal_indices <- 1:nrow(cov_matrix)
    cov_matrix[cbind(diagonal_indices, diagonal_indices)] <- 0

    # Convert the covariance matrix to an adjacency matrix with 1 for positive edges and -1 for negative edges
    adj_matrix <- ifelse(cov_matrix > 0, 1, ifelse(cov_matrix < 0, -1, 0))

    # Create an igraph graph object from the adjacency matrix
    graph <- graph_from_adjacency_matrix(adj_matrix, mode = "undirected")

    # Get the absolute values of the covariance matrix as edge weights
    edge_weights <- abs(cov_matrix)

    # Apply an absolute threshold value
    edge_weights[edge_weights < threshold] <- 0

    # Normalize edge weights to the range [0.1, 5] for line width
    normalized_edge_weights <- pmax(0.1, pmin(5, edge_weights))

    # Set up edge colors for positive and negative edges
    edge_colors <- ifelse(cov_matrix > 0, "blue", ifelse(cov_matrix < 0, "red", "black"))

    # Remove isolated nodes (unconnected elements)
    isolated_nodes <- which(degree(graph) == 0)
    graph <- delete.vertices(graph, isolated_nodes)

    # Get column and row names as node labels
    nodelab <- rownames(cov_matrix)  # Assuming row names are the same as column names

    # Plot the graph with edge weights, color-coded edges, and node labels
    plot(graph,
         layout = layout_randomly(graph),
         edge.color = edge_colors,
         edge.width = normalized_edge_weights*3,
         vertex_labels = nodelab,
         vertex.size = 3,
         vertex.label.cex = 0.8,  # Adjust the vertex label size
         vertex.label.color = "black",  # Adjust the vertex label color
         main = paste0("Network Difference", i))


    # names for the networks
    Graphs_name <- paste0("Network_Time", i)
    Diff_Networks[[Graphs_name]] <- graph
  }

  # Store the list of edge tables and graphical networks
  Obj[["DiffEdge_Table"]] <- DiffEdge_Table
  Obj[["Diff_Networks"]] <- Diff_Networks
  Obj
}
