# Curated 16S rRNA sequence databases and DPOT
Chieh Hua Lin

email : mammer@gapp.nthu.edu.tw

----

## About

The objective of this research was to establish a unified 16S rRNA database (U16S) via systematic curation, to standardize scientific nomenclature across taxonomic ranks, and consequently enhance the accuracy and interpretation of taxonomic classification. We compiled the most current 16S rRNA gene sequences from RefSeq, SILVA, and EzBioCloud databases. Given that each database employed varying methodologies in forming their taxonomic hierarchies, data comparison and consolidation presented significant challenges. Hence, we used the NCBI Taxonomy database as our benchmark standard for curating taxonomic information across the three databases.

We propose a refined approach for taxonomy assignment, which we term as DADA2 Pipeline with Optimized Taxonomy (DPOT). This method, based on the DADA2 pipeline, enhances accuracy by mitigating the misclassification of reads. DPOT uses the BLAST program to overcome DADA2's limitations in distinguishing closely related organisms. Our results demonstrate that DPOT, combined with curated SILVA or U16S, enables accurate species-level resolution. 

### Demostration of DD2B with U16S :
<https://mammerlin.github.io/DPOT/>

## Content

### Curated DB

For each curated database, FASTA files with BLAST and DADA2 format are provided in the following subfolders. All files were compressed into single zip file.

- EzBioCloud

  sequences from EzBioCloud updated on 2018.5

- RefSeq.16S

  sequences retrieved on Jaunary 19, 2023

- SILVA

  version 138.1 SSURef NR99

- U16S

  integration of three curated databases followed by removing duplicate sequences

### DPOT

The DADA2 Pipeline with Optimized Taxonomy (DPOT) implemented in this study was written in the R language.
