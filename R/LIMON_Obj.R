#' Counts to LIMON
#'
#'Create Formatted Objects to run LIMON from raw count tables
#'
#' @param Counts A genomic count table with samples as rows and taxa/genes/etc as columns
#' @param SampleData A sample data frame with row names matching "Counts"
#' @returns Returns a LIMON Object with the Counts and SampleData stored
#' @export
#'

LIMON_Obj <- function(Counts, SampleData){
  # Check if row names are identical and in the same order in Counts and SampleData
  if (!identical(rownames(Counts), rownames(SampleData))) {
    stop("Row names of Counts and SampleData tables are not identical. Make sure the names and order match between the two")
  }

  list(Counts = Counts, SampleData = SampleData)
  }

