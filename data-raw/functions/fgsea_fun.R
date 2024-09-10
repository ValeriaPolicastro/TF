#fgsea for cell type annotations
directory=as.character("/mnt/data_rstudio/home/tigem/s.slovin/data_shared/TF300/new_24/outputs/RNAseq/DESeq/")
sampleFiles <-as.character(grep("res",list.files(directory),value=TRUE))

H=gmtPathways("/mnt/data_rstudio/home/tigem/s.slovin/data_shared/TF300/new_24/outputs/geneset_list_cell_type_human_protein_atlas.gmt")

# Chabge gene ID to symbol
fgsea_function=function(file_name){
  res=readRDS(paste0(directory, file_name))
  res=na.omit(res)
  res=res[order(res$log2FoldChange, decreasing = T),]
  ranks=-log10(res$padj)*res$log2FoldChange
  names(ranks)=row.names(res)
  
  fgsea.res=data.frame(fgseaMultilevel(pathways = H, stats = ranks ))
  fgsea.res$final_score=fgsea.res$NES*(-log10(fgsea.res$padj))
  fgsea.res=fgsea.res[order(fgsea.res$final_score, decreasing = T),,drop=F]
  TF=unlist(strsplit(file_name, "_"))[1]
  fgsea.res$leadingEdge=paste0(unlist(fgsea.res$leadingEdge), collapse = ", ")
  write.csv(fgsea.res,paste0("/mnt/data_rstudio/home/tigem/s.slovin/data_shared/TF300/new_24/outputs/cell_type_annotation/", TF,"_fgsea.csv"))
  output.df=data.frame("TF"=TF,"top_3_cell_types"=paste0(fgsea.res$pathway[1:3], collapse = ", "))
  return(output.df)
}
cell_type_ann_by_DEA=do.call(rbind, lapply(sampleFiles, function(TF) fgsea_function(TF)))

write.csv(cell_type_ann_by_DEA, "/mnt/data_rstudio/home/tigem/s.slovin/data_shared/TF300/new_24/outputs/cell_type_annotation/leading_cell_type_annotations.csv")
