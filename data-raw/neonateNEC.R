## code to prepare `neonateNEC` dataset goes here

library(tidyverse)
NEC_Participant_data <- read.delim("data-raw/NICUNEC-1_Participant_subsettedData.txt")
NEC_Repeated_data <- read.delim("data-raw/NICUNEC-1_Participant repeated measure_subsettedData.txt")
NEC_Sample_data <- read.delim("data-raw/NICUNEC-1_Sample_subsettedData.txt")
NEC_Metagenomic_data <- read.delim("data-raw/NICUNEC-1_Metagenomic sequencing assay_subsettedData.txt")

usethis::use_data(NEC_Participant_data, NEC_Repeated_data, NEC_Sample_data,
                  NEC_Metagenomic_data, overwrite = T)

