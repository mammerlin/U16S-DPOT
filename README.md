# Curated 16S rRNA sequence databases and DD2B
Chieh Hua Lin

email : mammer@gapp.nthu.edu.tw

----

## About

The aim of this study was to construct a unified 16S rRNA database (U16S) with systematic curation to provide scientific nomenclature in taxonomic ranks and thus improve taxonomic classification accuracy and interpretation. Up-to-date 16S rRNA gene sequences were collected from the 16S ribosomal RNA data on the RefSeq,  SILVA, and EzBioCloud databases. Because the taxonomic hierarchies of the three databases were formed using different approaches, comparing and consolidating the data are challenging. Therefore, the NCBI Taxonomy database was used as the standard in curating the taxonomic information in the three databases.

We also propose an improved approach to taxonomy assignment, DD2B, which can increase the accuracy of taxonomic assignment by reducing the number of misclassified reads. DD2B was designed to overcome the shortcomings of the Ribosomal Database Project classifier, which cannot discriminate closely related organisms; this is achieved using the basic local alignment search tool (BLAST).

### Demostration of DD2B with U16S :
<https://mammerlin.github.io/DD2B/>

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

### DD2B

The new classification pipeline (DD2B) implemented in this study was written in the R language.
