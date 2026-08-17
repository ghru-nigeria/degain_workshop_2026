# https://pyseer.readthedocs.io/en/master/tutorial.html

require(ggplot2)
require(ggrepel)
library(ggrepel)

# gene_hits = read.table("Data/gene_hits.txt", stringsAsFactors=FALSE, header=TRUE)

gene_hits <- readr::read_tsv("Data/gene_hits.txt")

# average effect size
ggplot(gene_hits, aes(x=avg_beta, y=maxp, colour=avg_maf, size=hits, label=gene)) +
  geom_point(alpha=0.5) +
  geom_text_repel(aes(size=60), show.legend = FALSE, colour='black') +
  scale_size("Number of k-mers", range=c(1,10)) +
  scale_colour_gradient('Average MAF') +
  theme_bw(base_size=14) +
  ggtitle("Penicillin resistance") +
  xlab("Average effect size") +
  ylab("Maximum -log10(p-value)")

# average maf
ggplot(gene_hits, aes(x=avg_maf, y=maxp, colour=avg_beta, size=hits, label=gene)) +
  geom_point(alpha=0.5) +
  geom_text_repel(aes(size=60), show.legend = FALSE, colour='black') +
  scale_size("Number of k-mers", range=c(1,10)) +
  scale_colour_gradient('Average beta') +
  theme_bw(base_size=14) +
  ggtitle("Penicillin resistance") +
  xlab("Average MAF") +
  ylab("Maximum -log10(p-value)")

