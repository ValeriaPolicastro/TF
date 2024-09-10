## code to prepare `atac_dismatrix` dataset goes here

atac_dismatrix <- readRDS("~/GitHub/TF/data-raw/ATAC/ATAC_dis_matrix.RDS")

usethis::use_data(atac_dismatrix, overwrite = TRUE)
