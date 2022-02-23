#################
################# nonchimeric ASVs preparation by dada2::assignTaxonomy
### ASV fasta file : dada2.ASV.fasta
### ASV taxonomy : dada2.ASV.taxonomy.csv

path <- "~/DD2B" # CHANGE ME to the directory containing the required files.


#################
################# 1. Process DADA2 result
### import ASV taxonomy
ASV.taxonomy <- read.csv("dada2.ASV.taxonomy.csv")
### import ASV fasta
ASV.seq <- readBStringSet("dada2.ASV.fasta")

### pick up the ASVs were "NA" or indistinguishable species (including Shigella spp., Escherichia spp., Bacillus spp)
dada2.NA <- ASV.taxonomy %>% filter(grepl("NA|Shigella|Escherichia|Bacillus",taxonomy))
dada2.NA.seq <- ASV.seq[dada2.NA$ASV]
writeXStringSet(dada2.NA.seq,file="dada2.NA.ASV.fasta",format="fasta")


### dada2.NA were assigned taxonomy by BLAST
blast.dir <- "e:/ncbi-blast-2.12.0+/bin/blastn.exe"		 # CHANGE ME to the directory containing BLAST programe
blast.subject <- "U16S/U16S.blast_20220221.blastdb"		 # CHANGE ME to the directory containing reference database with blast format DB
blast.query <- "dada2.NA.ASV.fasta"
blast.out <- "dada2.NA.ASV.blast.fasta"
blast_script <- paste(blast.dir," -task megablast -query ",blast.query," -db ",blast.subject," -out ",blast.out," -num_threads 20 -outfmt \"6 sseqid qseqid qlen length qstart qend sstart send pident evalue score qcovs\" -max_target_seqs 10",sep="")
shell(blast_script)


#################
################# 2. process blast result
## import blast reslut
blast.result <- read.table(blast.out,sep="\t",header=F,fill=T,col.names=c("sseqid","qseqid","qlen","length","qstart","qend","sstart","send","pident","evalue","score","qcovs"))

source("20220223_DD2B_release_fun.R")

## mapping blsat dummy id to taxonomy according to blastIDmapping file
blast.IDmapping_file <- "U16S/U16S.blastIDmapping.txt"		# CHANGE ME to the directory containing blastIDmapping file
blast.IDmapping <- read.table(file=blast.IDmapping_file,header=T,sep="\t")
blast.result.2 <- merge(blast.result,blast.IDmapping[,c("rank.level","dummy.id")],by.x="sseqid",by.y="dummy.id",all.x=T)
tax.name.rank <- do.call(rbind,strsplit(blast.result.2$rank.level,";")) %>% as.data.frame
colnames(tax.name.rank) <- c("kingdom","phylum","class","order","family","genus","species")
blast.result.3 <- cbind(blast.result.2,tax.name.rank)

##### (a) hits with qcovs >80 were retained; 
blast.result.q80 <- blast.result.3 %>% filter(qcovs > 80)
blast.result.list <- split(blast.result.q80,blast.result.q80$qseqid)

## if all hits are uncultured bacterium, keep ; otherwise, remove uncultured bacterium
blast.result.list.2 <- lapply(blast.result.list[unlist(lapply(blast.result.list,nrow))> 0],uncultured.check.fun)

##### (b) at most, the three top hits with pident ≥ the highest pident (HPID) minus 0.2 were retained if HPID ≥99; and 
##### (c) at most, five top hits with pident ≥ HPID-0.2 were retained if HPID <99. 
blast.result.keep.pident <- lapply(blast.result.list.2,keep.pident.fun)


#################
################# 3. integrate BLAST reslut into DADA2 assignTaxonomy
dada2.NA$taxonomy <- unlist(lapply(blast.result.keep.pident[dada2.NA$ASV],'[',1,"rank.level"))
mock.set <- rbind(ASV.taxonomy %>% filter(!grepl("NA|Shigella|Escherichia|Bacillus",taxonomy)),dada2.NA)


################# 4. aggregate ASV
mock.set.2<- cbind(mock.set[,c("ASV","taxonomy")],
                   sapply(mock.set %>% select(-c(ASV,taxonomy)),as.numeric))
mock.set.aggreate <- aggregate(.~taxonomy,mock.set %>% select(-ASV),sum)
write.csv(mock.set.aggreate,file="mock.set.aggreate.csv")
