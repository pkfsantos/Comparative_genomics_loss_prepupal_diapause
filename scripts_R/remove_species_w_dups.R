#install.packages("seqinr")
args=commandArgs(trailingOnly=TRUE)
library(seqinr)
bee_fasta <- read.fasta(args[1],as.string = TRUE)
#here are all the sequences id names for species with individuals
#with more than one sequence
duplicates <- names(which(table(names(bee_fasta))>1))
#remove any species with more than one sequence
if(length(duplicates)>0){
  sans_seq_w_dups <- bee_fasta[-which(names(bee_fasta) %in% duplicates)]
}else{
  sans_seq_w_dups <- bee_fasta
}
#write back out as a fasta
write.fasta(sans_seq_w_dups,names = names(sans_seq_w_dups),
            as.string = TRUE,file.out = paste(args[1],"_dup_removed.fa",sep = "",
                                              collapse = ""))