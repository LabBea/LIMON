#' Fit a zero inflated negative binomial linear mixed model with covariate correction
#'
#' This function fits a mixed effect model with user specified distribution, covariates and subjects as random effects. The returned value are counts per time point that have had the covariate effect removed from them. We recommend users examine the distribution of their data before selection the appropriate model distribution and covariance structure. The default fit is a Linear Mixed Effect model, but the other options include a Zero Inflated Gaussian, Zero Inflated Negative Binomial, and Negative Binomial linear mixed effect models. The function will first convert the count table and sample data into a long formatted model table. The model will be fit with the outcome variable as "asvcounts" and the predictors as covariates to correct by with subjects modeled as random effects. Corrected counts are calculated by subtracting the covariate estimated coefficient*covariate value from the observed counts. Please see the paper documentation for more information.
#'
#' @param Obj (Required) A LIMON Object
#' @param Time (Required) A column in "SampleData" for the Time variable. Must be numeric ordinal (1,2,3, etc)
#' @param Subject (Required) A column of subject IDs. Used as
#' @param Covariates (Required) Specified string of columns from SampleData to use as covariates in the model
#' @param model (Required) Specify the right side of the lmer equation (the covariates to correct by)
#' @param correlation (Optional) Option to specify the correlation structure for model fitting ([Default] of NULL specifies unstructured). Follows the same covariance structure names as in NBZIMM
#' @param distribution (Optional) Specifies the distribution to fit for the linear mixed effect model. [Default] = "LMM", or the lmer() function from lme4. Other options include "LME.Z" = NBZIMM::lme.zig() , "GLMM.Z" = NBZIMM::lme.zig(), or "GLMM.NB" = NBZIMM::glmm.nb()
#' @returns LIMON Object with the addition; (1) Model_data: contains the Counts and SampleData in Long Format for the model. (2) equation: the formula for mixed effect model. (3) Model_res: The results from running the linear mixed model. (4) Corrected_Counts: corrected count values with samples as rows and taxa as columns. (5) Corrected_Counts_Time: corrected count values per time point with samples as rows and taxa as columns.
#' @export
#'
LIMON_DistrFit<- function (Obj, Time, Subject, Covariates, model,
                           distribution = "LMM", correlation = NULL)
{
  library(NBZIMM)
  library(lme4)

  # Check if rownames match between counts and sampledata
  if (!identical(rownames(Obj$Counts), rownames(Obj$SampleData))) {
    stop("Row names of Counts and SampleData tables are not identical. Make sure the rowname order matches between the two")
  }

  # Check if any columns sum to 0
  cols_with_zero_sum <- which(colSums(Obj$Counts) == 0)
  if (length(cols_with_zero_sum) > 0) {
    stop("Error: The count table contains taxa with a total abundance sum of 0. Remove those taxa.")
  }

  corrected_counts_list <- list()

  # Loop over each taxa
  for (col_name in colnames(Obj$Counts)) {

    # Prep the covariates
    model_data <- cbind(Obj$SampleData[, c(Time, Subject)],
                        Obj$Counts[, col_name])
    colnames(model_data) <- c("timepoint", "subjectid", "asvcounts")
    for (covariate in Covariates) {
      model_data[[covariate]] <- Obj$SampleData[[covariate]]
    }

    # Prep the model equation for LMM
    eq_lmm <- formula(paste("asvcounts", "~", model, "+ (1 | subjectid)"))

    # Prep the model equation for GLMM.Z, LME.Z, GLMM.NB
    eq <- formula(paste("asvcounts", "~", model))

    # check for 0's if LME.Z
    if (distribution == "LME.Z") {
      cols_without_zeros <- which(!apply(Obj$Counts, 2,
                                         function(col) any(col == 0)))
      if (length(cols_without_zeros) > 0) {
        stop("Error: The count table contains taxa without any 0 values. Choose a different distribution")
      }

      # Run the Model
      model_res <- NBZIMM::lme.zig(fixed = eq, random = ~1 |
                                     subjectid, data = model_data, correlation = correlation,
                                   zi_fixed = ~1)
    }
    # check for 0's if GLMM.Z
    else if (distribution == "GLMM.Z") {
      cols_without_zeros <- which(!apply(Obj$Counts, 2,
                                         function(col) any(col == 0)))
      if (length(cols_without_zeros) > 0) {
        stop("Error: The count table contains taxa without any 0 values. Choose a different distribution")
      }

      # Run the Model
      model_res <- NBZIMM::glmm.zinb(fixed = eq, offset = log(sum(model_data$asvcounts)),
                                     random = ~1 | subjectid, data = model_data, correlation = correlation,
                                     family = zi.negative.binomial(), zi_fixed = ~1)
    }

    # Run the LMM Model
    else if (distribution == "LMM") {
      model_res <- lmer(eq_lmm, data = model_data, REML = TRUE)
    }

    # Run the GLMM.NB Model
    else if (distribution == "GLMM.NB") {
      model_res <- NBZIMM::glmm.nb(fixed = eq, offset = log(sum(model_data$asvcounts)),
                                   random = ~1 | subjectid, data = model_data, correlation = correlation)
    }
    else {
      stop("Invalid distribution type. Choose from 'LME.Z', 'GLMM.Z', 'LMM', 'GLMM.NB'")
    }

    # Pull out the fixed effects
    Obj[["equation"]] <- eq
    Obj[["Model_res"]] <- model_res
    if (distribution == "LMM") {
      fixed_effects <- fixef(model_res)
      model_frame <- model_res@frame
    }
    else if (distribution %in% c("LME.Z", "GLMM.Z", "GLMM.NB")) {
      fixed_effects <- model_res[["coefficients"]][["fixed"]]
      model_frame <- model_res$data
    }
    else {
      stop("Invalid distribution type. Choose from 'LME.Z', 'GLMM.Z', 'LMM', 'GLMM.NB'")
    }

    # Correct the counts
    corrected_counts <- model_frame[["asvcounts"]]
    for (covariate in Covariates) {
      beta <- unname(fixed_effects[covariate])
      if (length(beta) == 1 && !is.na(beta)) {
        corrected_counts <- corrected_counts - beta *
          model_frame[[covariate]]
      }
    }
    corrected_counts_list[[col_name]] <- corrected_counts
  }

  # Rename the columns and rows
  Corrected_Counts <- as.data.frame(corrected_counts_list)
  for (col in names(Corrected_Counts)) {
    attr(Corrected_Counts[[col]], "label") <- NULL
  }
  colnames(Corrected_Counts) <- colnames(Obj[["Counts"]])
  rownames(Corrected_Counts) <- rownames(Obj[["Counts"]])

  # Round back to counts
  Corrected_Counts <- round(Corrected_Counts)
  Obj$Corrected_Counts <- Corrected_Counts

  # Save tables per timepoint
  timepoints <- unique(Obj[["SampleData"]][[Time]])
  Corrected_Counts_Timepoint <- list()
  for (tp in timepoints) {
    subset_sample_data <- Obj$SampleData[Obj$SampleData[[Time]] ==
                                           tp, ]
    timept_counts <- Obj$Corrected_Counts[row.names(Corrected_Counts) %in%
                                            row.names(subset_sample_data), ]
    timept_counts_name <- paste0("Corrected_Counts_", tp)
    Corrected_Counts_Timepoint[[timept_counts_name]] <- timept_counts
  }

  # Final Object
  Obj$Corrected_Counts_Time <- Corrected_Counts_Timepoint
  return(Obj)
}
