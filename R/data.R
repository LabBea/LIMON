#' @title NEC subset of Participant Data from "Necrotizing enterocolitis is preceded by increased gut bacterial replication, Klebsiella, and fimbriae-encoding bacteria." Olm et al. Sci Adv 2019;5(12):eaax5727
#' @description This was a NICU study that conducted deep metagenomic profiling of samples collected longitudinally from 150 pre-term infants. 30 of these infants developed necrotizing enterocolitis. For this example data, we used the MicrobiomeDB to pull the relative abundance metagenomic tables at the species level.
#' @format A data frame with 150 rows and 23 variables:
#' \describe{
#'   \item{\code{Participant_ID}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Age.at.study..days...EUPATH_0009212.}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{Stunted.at.birth..EUPATH_0009216.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Weight..g...IAO_0000414.}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{Sepsis.diagnosed..EUPATH_0009210.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Sex..PATO_0000047.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Contents.of.diet..EUPATH_0050531.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Country..ENVO_00000009.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Maternal.antepartum.antibiotics.administered..EUPATH_0009191.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Maternal.antepartum.antibiotics.administered.time..EUPATH_0009192.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Chorioamnionitis..EUPATH_0009175.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Group.B.Streptococcus.infection..EUPATH_0009172.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Necrotizing.enterocolitis..EUPATH_0009177.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Gestational.age.at.birth..days...EUPATH_0009095.}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{Delivery.mode..EUPATH_0000581.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Amnionicity..EUPATH_0009187.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Birth.plurality..EUPATH_0009186.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Chorionicity..EUPATH_0009188.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Twin.type..EUPATH_0009189.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Season.of.birth..EUPATH_0009209.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Sibling.set.ID..EUPATH_0009215.}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{Study.group..EUPATH_0000639.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Survived..EUPATH_0009211.}}{character COLUMN_DESCRIPTION}
#'}
#' @source \url{https://microbiomedb.org/mbio/app/workspace/analyses/DS_84fcb69f4e/new/details}
"NEC_Participant_data"
#'
#' @title NEC subset of Repeated Data from "Necrotizing enterocolitis is preceded by increased gut bacterial replication, Klebsiella, and fimbriae-encoding bacteria." Olm et al. Sci Adv 2019;5(12):eaax5727
#' @description This was a NICU study that conducted deep metagenomic profiling of samples collected longitudinally from 150 pre-term infants. 30 of these infants developed necrotizing enterocolitis. For this example data, we used the MicrobiomeDB to pull the relative abundance metagenomic tables at the species level.
#' @format A data frame with 1097 rows and 4 variables:
#' \describe{
#'   \item{\code{Participant_repeated_measure_ID}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Participant_ID}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Days.of.period.NEC.diagnosed..days...EUPATH_0009213.}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{Age..days...OBI_0001169.}}{integer COLUMN_DESCRIPTION}
#'}
#' @source \url{https://microbiomedb.org/mbio/app/workspace/analyses/DS_84fcb69f4e/new/details}
"NEC_Repeated_data"
#'
#' @title NEC subset of Sample Data from "Necrotizing enterocolitis is preceded by increased gut bacterial replication, Klebsiella, and fimbriae-encoding bacteria." Olm et al. Sci Adv 2019;5(12):eaax5727
#' @description This was a NICU study that conducted deep metagenomic profiling of samples collected longitudinally from 150 pre-term infants. 30 of these infants developed necrotizing enterocolitis. For this example data, we used the MicrobiomeDB to pull the relative abundance metagenomic tables at the species level.
#' @format A data frame with 1124 rows and 24 variables:
#' \describe{
#'   \item{\code{Sample_ID}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Participant_repeated_measure_ID}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Participant_ID}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Habitat..ENVO_01000739.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Host.body.habitat..UBERON_0000466.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Host.body.product..UBERON_0000463.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Host.body.site..UBERON_0000061.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Methicillin.resistant.Staphylococcus.aureus..ARO_3004306.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Sample.type..OBI_0100051.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Acyclovir..EUPATH_0009194.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Amoxicillin..EUPATH_0009195.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Ampicillin..EUPATH_0009196.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Cefazolin..EUPATH_0009197.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Cefepime..EUPATH_0009198.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Cefotaxime..EUPATH_0009199.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Claforan..EUPATH_0009200.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Clindamycin..EUPATH_0009201.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Fluconazole..EUPATH_0009202.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Gentamycin..EUPATH_0009203.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Nafcillin..EUPATH_0009204.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Nystatin..EUPATH_0009205.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Ofloxacin..EUPATH_0009206.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Vancomycin..EUPATH_0009207.}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Zosyn..EUPATH_0009208.}}{character COLUMN_DESCRIPTION}
#'}
#' @source \url{https://microbiomedb.org/mbio/app/workspace/analyses/DS_84fcb69f4e/new/details}
"NEC_Sample_data"
#'
#' @title NEC subset of relative Metagenomic counts from "Necrotizing enterocolitis is preceded by increased gut bacterial replication, Klebsiella, and fimbriae-encoding bacteria." Olm et al. Sci Adv 2019;5(12):eaax5727
#' @description This was a NICU study that conducted deep metagenomic profiling of samples collected longitudinally from 150 pre-term infants. 30 of these infants developed necrotizing enterocolitis. For this example data, we used the MicrobiomeDB to pull the relative abundance metagenomic tables at the genus level.
#' @format A data frame with 1118 rows and 137 variables:
#' \describe{
#'   \item{\code{Metagenomic_sequencing_assay_ID}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Sample_ID}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Participant_repeated_measure_ID}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Participant_ID}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Actinomyces..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Actinomycetales_Actinomycetaceae_Actinomyces.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Trueperella..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Actinomycetales_Actinomycetaceae_Trueperella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Varibaculum..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Actinomycetales_Actinomycetaceae_Varibaculum.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Aeriscardovia..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Bifidobacteriales_Bifidobacteriaceae_Aeriscardovia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Alloscardovia..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Bifidobacteriales_Bifidobacteriaceae_Alloscardovia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Bifidobacterium..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Bifidobacteriales_Bifidobacteriaceae_Bifidobacterium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Corynebacterium..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Corynebacteriales_Corynebacteriaceae_Corynebacterium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Gordonia..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Corynebacteriales_Gordoniaceae_Gordonia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Mycobacteroides..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Corynebacteriales_Mycobacteriaceae_Mycobacteroides.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Dermabacter..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Micrococcales_Dermabacteraceae_Dermabacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Micrococcus..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Micrococcales_Micrococcaceae_Micrococcus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Rothia..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Micrococcales_Micrococcaceae_Rothia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Cutibacterium..EUPATH_0009256_Bacteria_Actinobacteria_Actinobacteria_Propionibacteriales_Propionibacteriaceae_Cutibacterium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Atopobium..EUPATH_0009256_Bacteria_Actinobacteria_Coriobacteriia_Coriobacteriales_Atopobiaceae_Atopobium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Collinsella..EUPATH_0009256_Bacteria_Actinobacteria_Coriobacteriia_Coriobacteriales_Coriobacteriaceae_Collinsella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Enorma..EUPATH_0009256_Bacteria_Actinobacteria_Coriobacteriia_Coriobacteriales_Coriobacteriaceae_Enorma.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Adlercreutzia..EUPATH_0009256_Bacteria_Actinobacteria_Coriobacteriia_Eggerthellales_Eggerthellaceae_Adlercreutzia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Asaccharobacter..EUPATH_0009256_Bacteria_Actinobacteria_Coriobacteriia_Eggerthellales_Eggerthellaceae_Asaccharobacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Denitrobacterium..EUPATH_0009256_Bacteria_Actinobacteria_Coriobacteriia_Eggerthellales_Eggerthellaceae_Denitrobacterium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Eggerthella..EUPATH_0009256_Bacteria_Actinobacteria_Coriobacteriia_Eggerthellales_Eggerthellaceae_Eggerthella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Enterorhabdus..EUPATH_0009256_Bacteria_Actinobacteria_Coriobacteriia_Eggerthellales_Eggerthellaceae_Enterorhabdus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Gordonibacter..EUPATH_0009256_Bacteria_Actinobacteria_Coriobacteriia_Eggerthellales_Eggerthellaceae_Gordonibacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Slackia..EUPATH_0009256_Bacteria_Actinobacteria_Coriobacteriia_Eggerthellales_Eggerthellaceae_Slackia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Bacteroides..EUPATH_0009256_Bacteria_Bacteroidetes_Bacteroidia_Bacteroidales_Bacteroidaceae_Bacteroides.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Prevotella..EUPATH_0009256_Bacteria_Bacteroidetes_Bacteroidia_Bacteroidales_Prevotellaceae_Prevotella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Alistipes..EUPATH_0009256_Bacteria_Bacteroidetes_Bacteroidia_Bacteroidales_Rikenellaceae_Alistipes.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Parabacteroides..EUPATH_0009256_Bacteria_Bacteroidetes_Bacteroidia_Bacteroidales_Tannerellaceae_Parabacteroides.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Capnocytophaga..EUPATH_0009256_Bacteria_Bacteroidetes_Flavobacteriia_Flavobacteriales_Flavobacteriaceae_Capnocytophaga.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Cloacibacterium..EUPATH_0009256_Bacteria_Bacteroidetes_Flavobacteriia_Flavobacteriales_Flavobacteriaceae_Cloacibacterium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Oscillatoria..EUPATH_0009256_Bacteria_Cyanobacteria_Cyanobacteria_unclassified_Oscillatoriales_Oscillatoriaceae_Oscillatoria.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Bacillus..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Bacillales_Bacillaceae_Bacillus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Lysinibacillus..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Bacillales_Bacillaceae_Lysinibacillus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Gemella..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Bacillales_Bacillales_unclassified_Gemella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Paenibacillus..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Bacillales_Paenibacillaceae_Paenibacillus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Staphylococcus..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Bacillales_Staphylococcaceae_Staphylococcus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Granulicatella..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Lactobacillales_Carnobacteriaceae_Granulicatella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Enterococcus..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Lactobacillales_Enterococcaceae_Enterococcus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Lactobacillus..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Lactobacillales_Lactobacillaceae_Lactobacillus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Leuconostoc..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Lactobacillales_Leuconostocaceae_Leuconostoc.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Weissella..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Lactobacillales_Leuconostocaceae_Weissella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Lactococcus..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Lactobacillales_Streptococcaceae_Lactococcus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Streptococcus..EUPATH_0009256_Bacteria_Firmicutes_Bacilli_Lactobacillales_Streptococcaceae_Streptococcus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Clostridium..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Clostridiaceae_Clostridium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Hungatella..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Clostridiaceae_Hungatella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Eubacterium..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Eubacteriaceae_Eubacterium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Anaerocolumna..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Anaerocolumna.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Blautia..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Blautia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Coprococcus..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Coprococcus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Dorea..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Dorea.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Eisenbergiella..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Eisenbergiella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Fusicatenibacter..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Fusicatenibacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Lachnoanaerobaculum..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Lachnoanaerobaculum.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Lachnoclostridium..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Lachnoclostridium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Lachnospiraceae_unclassified..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Lachnospiraceae_unclassified.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Robinsoniella..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Robinsoniella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Roseburia..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Roseburia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Tyzzerella..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Lachnospiraceae_Tyzzerella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Peptococcus..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Peptococcaceae_Peptococcus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Clostridioides..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Peptostreptococcaceae_Clostridioides.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Intestinibacter..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Peptostreptococcaceae_Intestinibacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Paeniclostridium..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Peptostreptococcaceae_Paeniclostridium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Paraclostridium..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Peptostreptococcaceae_Paraclostridium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Peptostreptococcus..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Peptostreptococcaceae_Peptostreptococcus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Romboutsia..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Peptostreptococcaceae_Romboutsia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Terrisporobacter..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Peptostreptococcaceae_Terrisporobacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Agathobaculum..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Ruminococcaceae_Agathobaculum.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Anaerotruncus..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Ruminococcaceae_Anaerotruncus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Faecalibacterium..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Ruminococcaceae_Faecalibacterium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Flavonifractor..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Ruminococcaceae_Flavonifractor.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Ruminococcus..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Ruminococcaceae_Ruminococcus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Ruthenibacterium..EUPATH_0009256_Bacteria_Firmicutes_Clostridia_Clostridiales_Ruminococcaceae_Ruthenibacterium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Dialister..EUPATH_0009256_Bacteria_Firmicutes_Negativicutes_Veillonellales_Veillonellaceae_Dialister.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Megasphaera..EUPATH_0009256_Bacteria_Firmicutes_Negativicutes_Veillonellales_Veillonellaceae_Megasphaera.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Negativicoccus..EUPATH_0009256_Bacteria_Firmicutes_Negativicutes_Veillonellales_Veillonellaceae_Negativicoccus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Veillonella..EUPATH_0009256_Bacteria_Firmicutes_Negativicutes_Veillonellales_Veillonellaceae_Veillonella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Veillonellaceae_unclassified..EUPATH_0009256_Bacteria_Firmicutes_Negativicutes_Veillonellales_Veillonellaceae_Veillonellaceae_unclassified.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Anaerococcus..EUPATH_0009256_Bacteria_Firmicutes_Tissierellia_Tissierellales_Peptoniphilaceae_Anaerococcus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Finegoldia..EUPATH_0009256_Bacteria_Firmicutes_Tissierellia_Tissierellales_Peptoniphilaceae_Finegoldia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Peptoniphilus..EUPATH_0009256_Bacteria_Firmicutes_Tissierellia_Tissierellales_Peptoniphilaceae_Peptoniphilus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Fusobacterium..EUPATH_0009256_Bacteria_Fusobacteria_Fusobacteriia_Fusobacteriales_Fusobacteriaceae_Fusobacterium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Sneathia..EUPATH_0009256_Bacteria_Fusobacteria_Fusobacteriia_Fusobacteriales_Leptotrichiaceae_Sneathia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Brevundimonas..EUPATH_0009256_Bacteria_Proteobacteria_Alphaproteobacteria_Caulobacterales_Caulobacteraceae_Brevundimonas.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Bradyrhizobium..EUPATH_0009256_Bacteria_Proteobacteria_Alphaproteobacteria_Rhizobiales_Bradyrhizobiaceae_Bradyrhizobium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Agrobacterium..EUPATH_0009256_Bacteria_Proteobacteria_Alphaproteobacteria_Rhizobiales_Rhizobiaceae_Agrobacterium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Roseomonas..EUPATH_0009256_Bacteria_Proteobacteria_Alphaproteobacteria_Rhodospirillales_Acetobacteraceae_Roseomonas.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Sphingomonas..EUPATH_0009256_Bacteria_Proteobacteria_Alphaproteobacteria_Sphingomonadales_Sphingomonadaceae_Sphingomonas.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Lautropia..EUPATH_0009256_Bacteria_Proteobacteria_Betaproteobacteria_Burkholderiales_Burkholderiaceae_Lautropia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Acidovorax..EUPATH_0009256_Bacteria_Proteobacteria_Betaproteobacteria_Burkholderiales_Comamonadaceae_Acidovorax.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Eikenella..EUPATH_0009256_Bacteria_Proteobacteria_Betaproteobacteria_Neisseriales_Neisseriaceae_Eikenella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Neisseria..EUPATH_0009256_Bacteria_Proteobacteria_Betaproteobacteria_Neisseriales_Neisseriaceae_Neisseria.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Aeromonas..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Aeromonadales_Aeromonadaceae_Aeromonas.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Shewanella..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Alteromonadales_Shewanellaceae_Shewanella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Atlantibacter..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Atlantibacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Citrobacter..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Citrobacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Cronobacter..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Cronobacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Enterobacter..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Enterobacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Escherichia..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Escherichia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Franconibacter..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Franconibacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Klebsiella..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Klebsiella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Kluyvera..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Kluyvera.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Kosakonia..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Kosakonia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Leclercia..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Leclercia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Metakosakonia..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Metakosakonia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Pluralibacter..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Pluralibacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Raoultella..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacteriaceae_Raoultella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Mixta..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Erwiniaceae_Mixta.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Pantoea..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Erwiniaceae_Pantoea.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Hafnia..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Hafniaceae_Hafnia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Morganella..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Morganellaceae_Morganella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Proteus..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Morganellaceae_Proteus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Serratia..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Enterobacterales_Yersiniaceae_Serratia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Aggregatibacter..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Pasteurellales_Pasteurellaceae_Aggregatibacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Haemophilus..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Pasteurellales_Pasteurellaceae_Haemophilus.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Acinetobacter..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Pseudomonadales_Moraxellaceae_Acinetobacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Moraxella..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Pseudomonadales_Moraxellaceae_Moraxella.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Pseudomonas..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Pseudomonadales_Pseudomonadaceae_Pseudomonas.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Stenotrophomonas..EUPATH_0009256_Bacteria_Proteobacteria_Gammaproteobacteria_Xanthomonadales_Xanthomonadaceae_Stenotrophomonas.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Mycoplasma..EUPATH_0009256_Bacteria_Tenericutes_Mollicutes_Mycoplasmatales_Mycoplasmataceae_Mycoplasma.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Ureaplasma..EUPATH_0009256_Bacteria_Tenericutes_Mollicutes_Mycoplasmatales_Mycoplasmataceae_Ureaplasma.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Akkermansia..EUPATH_0009256_Bacteria_Verrucomicrobia_Verrucomicrobiae_Verrucomicrobiales_Akkermansiaceae_Akkermansia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Xanthomonadaceae_unclassified..EUPATH_0009256_Bacteria_bacteria_Gammaproteobacteria_Xanthomonadales_Xanthomonadaceae_Xanthomonadaceae_unclassified.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Pseudescherichia..EUPATH_0009256_Bacteria_chia.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Campylobacter..EUPATH_0009256_Bacteria_cter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Yersiniaceae_unclassified..EUPATH_0009256_Bacteria_d.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Enhydrobacter..EUPATH_0009256_Bacteria_eobacteria_Alphaproteobacteria_Rhodospirillales_Rhodospirillales_unclassified_Enhydrobacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Propionimicrobium..EUPATH_0009256_Bacteria_ium.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Lawsonella..EUPATH_0009256_Bacteria_la.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Mogibacterium..EUPATH_0009256_Bacteria_m.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Phytobacter..EUPATH_0009256_Bacteria_oteobacteria_Gammaproteobacteria_Enterobacterales_Enterobacterales_unclassified_Phytobacter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Superficieibacter..EUPATH_0009256_Bacteria_ter.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Erysipelatoclostridium..EUPATH_0009256_Bacteria_um.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Candida..EUPATH_0009256_Eukaryota_Ascomycota_Saccharomycetes_Saccharomycetales_Debaryomycetaceae_Candida.}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Malassezia..EUPATH_0009256_Eukaryota_Basidiomycota_Malasseziomycetes_Malasseziales_Malasseziaceae_Malassezia.}}{double COLUMN_DESCRIPTION}
#'}
#' @source \url{https://microbiomedb.org/mbio/app/workspace/analyses/DS_84fcb69f4e/new/details}
"NEC_Metagenomic_data"
