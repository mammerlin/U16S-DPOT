##### (a) hits with qcovs >80 were retained; 
## if all hits are uncultured bacterium, keep ; otherwise, remove uncultured bacterium

uncultured.check.fun <- function(uncultured.check){
    rm.uncultured <- uncultured.check %>% filter(species != "uncultured bacterium")
    if(nrow(rm.uncultured) > 0){
        return(rm.uncultured)
    }else return(uncultured.check)
}

##### (b) at most, the three top hits with pident ≥ the highest pident (HPID) minus 0.2 were retained if HPID ≥99
keep.pident.fun <- function(keep.pident.query){
		##sort by BLAST and qcovs
		keep.pident.query <- keep.pident.query %>% arrange(desc(score,qcovs,pident))
		
    if(sum(keep.pident.query$pident > 99) == 0 ){
      keep.out <- keep.pident.query[1:5,]            
    } else{
        keep.out <- keep.pident.query[1:3,]           
    }
    keep.out.2 <- keep.out %>% arrange(desc(pident)) %>% filter(pident > max(keep.out$pident) - 0.2)
    
    ##
  if(sum(keep.out.2$pident == 100) == 1){
  	keep.out.3 <- keep.out.2 %>% filter(pident == 100)
  }else 
  if(sum(keep.out.2$pident == 100) > 1){
  	keep.out.2_1 <- keep.out.2 %>% filter(pident == 100)
  	tmp.g.level <- paste(unique(keep.out.2_1$genus),collapse="|")
  	tmp.s.level <- paste(unique(keep.out.2_1$species),collapse="|")
  	tmp.rank.level <- paste(
  		paste(keep.out.2_1[1,] %>% select(kingdom,phylum,class,order,family),collapse=";"),
  		tmp.g.level,tmp.s.level,sep=";")     	
  	keep.out.3 <- keep.out.2_1
  	keep.out.3$rank.level <- tmp.rank.level
  }else
	if(sort(table(keep.out.2$species),decreasing=TRUE) %>% unique %>% length == 1){
        keep.out.2_1 <- keep.out.2 %>% filter(genus == sort(table(keep.out.2$genus),decreasing=TRUE)[1] %>% names)
  	tmp.g.level <- paste(unique(keep.out.2_1$genus),collapse="|")
  	tmp.s.level <- paste(unique(keep.out.2_1$species),collapse="|")
  	tmp.rank.level <- paste(
  		paste(keep.out.2_1[1,] %>% select(kingdom,phylum,class,order,family),collapse=";"),
  		tmp.g.level,tmp.s.level,sep=";")     	
      	
      	keep.out.3 <- keep.out.2_1
      	keep.out.3$rank.level <- tmp.rank.level

    }else{
        ## decide the output by majority rule
        keep.out.3 <- keep.out.2 %>% filter(species == sort(table(keep.out.2$species),decreasing=TRUE)[1] %>% names)
    }
    return(keep.out.3[1,])
}
