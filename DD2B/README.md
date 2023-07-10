# DPOT

DPOT was developed for taxonomic assignment, utilizing both the RDP Classifier in DADA2 (assignTaxonomy function) and BLAST. In cases where amplicon sequence variants (ASVs) were either unassigned at the species level (resulting in NA output) or assigned to known indistinguishable species (such as Shigella spp., Escherichia spp., Bacillus spp.) by DADA2 assignTaxonomy in conjunction with a database, the sequence underwent a BLAST search against the respective database for species assignment.

## Content
### Main script
- DPOT.R : DPOT R script
- DPOT_fun.R : the subfunction 
### Curated 16S rRNA sequence databases 
BLAST database formate by makeblastdb from FASTA files







