
# Bayesian population structure analysis using fastBAPS
# Usage: Rscript scripts/03_fastbaps.R
# Input: core genome alignment in Panaroo_out

#--load libraries--
library(fastbaps)
library(ape)

# Input and Output pathways
alignment.file <- "panaroo_out/core_gene_alignment.aln"
output.dir <- "fastbaps_out"

# create the output dir
dir.create(output.dir, showWarnings = FALSE)

# Load alignment file
cat("[INFO] Loading alignment...\n")
sparse.data <- import_fasta_sparse_nt(alignment.file)

# Optimise prior
cat("[INFO] Optimising prior...\n")
sparse.data <- optimise_prior(sparse.data, type = "optimise.symmetric")

# Run fastBAPS at multiple levels
cat("[INFO] Running fastBAPS...\n")
multi <- multi_res_baps(sparse.data)

# Save results
cat("[INFO] Saving results...\n")
write.csv(multi, file.path(output.dir, "fastbaps_clusters.csv"), row.names = TRUE)

cat("[INFO] Done. Results saved to", output.dir, "\n")
