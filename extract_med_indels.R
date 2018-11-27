#!/usr/local/bin/Rscript

a <- commandArgs(T)
if (length(a) == 1) {
    a[2] <- sub(".vcf", ".mtr.vcf", a[1])
}
vcf <- readLines(a[1])

info_lines <- grep("^#", vcf)
info <- vcf[info_lines]
vars <- vcf[-info_lines]
vars_TR <- vars[grep("STR", vars)]
vars_TR_unit <- gsub(";.*$", "", gsub("^.*RU=", "", vars_TR))
vars_MTR <- vars_TR[nchar(vars_TR_unit) >= 10]
writeLines(c(info, vars_MTR), a[2])