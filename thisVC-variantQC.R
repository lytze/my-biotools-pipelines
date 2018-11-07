#!/usr/local/bin/Rscript
require(ggplot2)
a <- commandArgs(T)
FO <- a[1]
if (!dir.exists("variantQC")) dir.create("variantQC")
system(paste0(
    "~/biotools/gatk-4.0.11.0/gatk VariantsToTable ",
    "-V variantCall/", FO, ".vcf ",
    "-O variantQC/", FO, ".tsv ",
    "-F TYPE -F QD -F FS -F MQ -F DP -F SOR"))
setwd("variantQC")
data <- read.delim(paste0(FO, ".tsv"))

ggplot(data = data) +
    geom_density(mapping = aes(x = FS, color = TYPE, fill = TYPE), alpha = 0.2) + 
    labs(x = "Fisher Strand Bias",
         title = "Variant Calling Quality Control",
         subtitle = paste0("Sample: ", FO)) -> g
ggsave(paste0(FO, ".FS.png"), plot = g, width = 6, height = 3.5, device = png())

ggplot(data = data) +
    geom_density(mapping = aes(x = QD, color = TYPE, fill = TYPE), alpha = 0.2) + 
    labs(x = "Quality by Depth",
         title = "Variant Calling Quality Control",
         subtitle = paste0("Sample: ", FO)) -> g
ggsave(paste0(FO, ".DQ.png"), plot = g, width = 6, height = 3.5, device = png())

ggplot(data = data) +
    geom_density(mapping = aes(x = SOR, color = TYPE, fill = TYPE), alpha = 0.2) + 
    labs(x = "Strand Odds Ratio",
         title = "Variant Calling Quality Control",
         subtitle = paste0("Sample: ", FO)) -> g
ggsave(paste0(FO, ".SOR.png"), plot = g, width = 6, height = 3.5, device = png())

ggplot(data = data) +
    geom_density(mapping = aes(x = MQ, color = TYPE, fill = TYPE), alpha = 0.2) + 
    labs(x = "Mean Square Root of Mapping Quality",
         title = "Variant Calling Quality Control",
         subtitle = paste0("Sample: ", FO)) -> g
ggsave(paste0(FO, ".MQ.png"), plot = g, width = 6, height = 3.5, device = png())
