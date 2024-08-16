#' Individual network characteristics
#'
#' Calculate network centralities from each individual graph and add to Sample Data from export. Returns average Degree Centrality, average Closeness Centrality, average Betweenness Centrality, Eigenvector Centrality, and total Communities per sample.
#'
#' @param Obj LIMON Object from LIMON_NetInf_Time()
#' @param threshold (Optional) Same threshold parameter used in the LIMON_IndEdges step. [Default] = 0.2
#'
#' @return LIMON Object with updated SampleData that contains network centralities per sample. SampleData is written to Global environment as LIMON_SampleData. Note the number of random walks for the Communities is 30
#' @export
#'
LIMON_Centralities <- function (Obj, threshold = 0.2)
  {
    # Initialize Objects
    SampleData <- Obj$SampleData
    Individual_Networks <- Obj$Individual_Networks
    degree_values <- numeric(length(rownames(SampleData)))
    closeness_values <- numeric(length(rownames(SampleData)))
    betweenness_values <- numeric(length(rownames(SampleData)))
    eigenvector_values <- numeric(length(rownames(SampleData)))
    communities <- numeric(length(rownames(SampleData)))

    for (i in 1:nrow(SampleData)) {
      # Make graphs per person per time
      sample_id <- rownames(SampleData)[i]
      cov_matrix <- Individual_Networks[[sample_id]]
      diagonal_indices <- 1:nrow(cov_matrix)
      cov_matrix[cbind(diagonal_indices, diagonal_indices)] <- 0
      cov_matrix[abs(cov_matrix) < threshold] <- 0
      adj_matrix <- sign(cov_matrix)
      graph <- graph_from_adjacency_matrix(abs(adj_matrix),
                                           mode = "undirected", weighted = NULL)

      # Calculate Centralities
      degree_values[i] <- mean(degree(graph), na.rm = TRUE)
      closeness_values[i] <- mean(closeness(graph), na.rm = TRUE)
      betweenness_values[i] <- mean(betweenness(graph), na.rm = TRUE)
      eigenvector_value <- eigen_centrality(graph)
      eigenvector_values[i] <- eigenvector_value[["value"]]
      communities[i] <- max(membership(cluster_walktrap(graph,
                                                        steps = 30)))
    }
    # Save Centralities
    SampleData$DegreeCentrality <- degree_values
    SampleData$ClosenessCentrality <- closeness_values
    SampleData$BetweennessCentrality <- betweenness_values
    SampleData$EigenCentrality <- eigenvector_values
    SampleData$Communities <- communities

    Obj$SampleData <- SampleData
    assign("LIMON_SampleData", SampleData, envir = .GlobalEnv)
    return(Obj)
  }
