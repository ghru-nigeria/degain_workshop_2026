# Bacterial Recombination Detection Training (DEGAiN)

## Overview

This training equips participants with the knowledge and practical skills to detect, quantify, and correctly interpret homologous recombination in bacterial genomes, and to account for its effects when reconstructing phylogenies and drawing epidemiological conclusions.

## Learning Objectives

By the end of the course, participants should be able to:

- **Explain why recombination matters.** Describe how homologous recombination introduces localized clusters of SNPs into bacterial genomes and how, if left unaccounted for, these regions can inflate branch lengths and distort phylogenetic tree topology.
- **Understand bioinformatics workflows for recombination analysis.** Explain the purpose and underlying principles of key tools used in recombination analysis, including Mash (rapid genome distance estimation, clustering, and reference selection), Snippy (reference-based variant calling and whole-genome alignment), and Gubbins (recombination detection and masking).
- **Perform end-to-end recombination analysis.** Gain hands-on experience running a complete bioinformatics workflow for recombination detection, from reference selection and genome alignment to phylogenetic reconstruction and recombination masking.
- **Interpret recombination metrics.** Correctly interpret Gubbins per-branch statistics, including SNPs inside and outside recombination regions, recombination blocks, bases in recombination, the clonal frame, r/m (the relative impact of recombination versus mutation on genetic diversity), and rho/theta (the relative rate of recombination to mutation events).
- **Visualize, compare, and critically evaluate recombination results.** Use R and Phandango to visualize recombination events and summary statistics, compare recombination patterns across DEC lineages, assess the strengths and limitations of the analyses, and identify the most recombinogenic lineages.

## Repository Structure

```
.
├── data/
│   ├── cluster12/        # Gubbins outputs + reference genome for lineage 12
│   ├── cluster17/        # Gubbins outputs + reference genome for lineage 17
│   └── cluster20/        # Gubbins outputs + reference genome for lineage 20
├── scripts/
│   ├── recombination_DEC2_lineages.R          # Compares recombination stats across DEC lineages
│   └── DEGAiN_workbook_recombination_module1.pdf  # Course workbook
└── degain_recombination_slides.pptx            # Training slides
```

Each `data/cluster*/` folder contains the Gubbins outputs for that lineage:

- `gubbins.node_labelled.final_tree.tre` — final recombination-corrected phylogeny
- `gubbins.per_branch_statistics.csv` — per-branch recombination statistics (tab-separated despite the `.csv` extension)
- `gubbins.recombination_predictions.gff` — predicted recombinant regions
- `reference_c*.fna` / `reference_c*.gff3` — reference genome and annotation used for alignment
- `metadata.csv` — sample metadata for the cluster

## Prerequisites

- [Mash](https://github.com/marbl/Mash)
- [Snippy](https://github.com/tseemann/snippy)
- [Gubbins](https://github.com/nickjcroucher/gubbins)
- R with the `tidyverse`, `janitor`, `ggpubr`, and `patchwork` packages
- [Phandango](https://jameshadfield.github.io/phandango/) (browser-based, for visualizing Gubbins output)

## Usage

To reproduce the cross-lineage comparison figures:

1. Open `scripts/recombination_DEC2_lineages.R`.
2. Update the `setwd()` call to point at your local copy of the `data/` directory.
3. Run the script in R/RStudio — it reads each cluster's `gubbins.per_branch_statistics.csv`, combines lineages 12, 17, and 20, and generates comparison plots of SNPs inside/outside recombination regions.

See `scripts/DEGAiN_workbook_recombination_module1.pdf` for the full hands-on walkthrough and `degain_recombination_slides.pptx` for the accompanying lecture material.
