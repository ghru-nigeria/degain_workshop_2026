# Bacterial Population Structure

A workflow to infer population structure from bacterial genomes using genome annotation, pangenome analysis, and Bayesian clustering.



## Workflow

| Step | Tool | Script |
|------|------|--------|
| 1. Genome Annotation | Bakta | `scripts/01_bakta_annotation.sh` |
| 2. Pangenome Analysis | Panaroo | `scripts/02_panaroo_pangenome.sh` |
| 3. Population Structure | fastBAPS | `scripts/03_fastbaps.R` |


## Requirements

Conda environment yml files are provided in `envs/`. To create each environment:

```bash
conda env create -f envs/bakta_env.yml
conda env create -f envs/panaroo_env.yml
conda env create -f envs/fastbaps_env.yml
```

- [Bakta GitHub](https://github.com/oschwengers/bakta) (see database setup instructions)
- [Panaroo GitHub](https://github.com/gtonkinhill/panaroo)
- [fastBAPS GitHub](https://github.com/gtonkinhill/fastbaps)


## Step 1: Genome Annotation (Bakta)

### Database setup
Follow instructions at [https://github.com/oschwengers/bakta](https://github.com/oschwengers/bakta) to download the database into `db_bakta/`.

### Run
```bash
conda activate degain_bakta
bash scripts/01_bakta_annotation.sh
```

Annotates all `.fasta` files in `genomes/`, writing output to `bakta_out/` and logs to `logs/`.


## Step 2: Pangenome Analysis (Panaroo)

### Run

```bash
conda activate degain_panaroo
bash scripts/02_panaroo_pangenome.sh
```

The script automatically generates a list of all GFF3 files in `bakta_out/` and runs Panaroo with the following settings:

- `--clean-mode sensitive` — recommended 
- `--remove-invalid-genes` — required for Bakta GFF3 compatibility
- `-a core` — generates core genome alignment for downstream population structure analysis
- `--core_threshold 0.95` — genes present in ≥95% of genomes are classified as core, default

Output is written to `panaroo_out/`. The key output for downstream analysis is `panaroo_out/core_gene_alignment.aln`.

## Step 3: Population Structure (fastBAPS)

### Run

```bash
conda activate degain_fastbaps
Rscript scripts/03_fastbaps.R
```

Input file is the core genome alignment from Panaroo (`panaroo_out/core_gene_alignment.aln`).

- `optimise_prior(optimise.symmetric)` was used

Output is written in `fastbaps_out/`, the result is saved as `fastbaps_clusters.csv`, it shows 2 levels.



## Acknowledgements

We thank the developers of Bakta, Panaroo, and fastBAPS for making their software openly available. Users of this pipeline should cite the original tools when publishing results.

## Citations

If you use this pipeline, please cite the following tools:

**Bakta**
Schwengers O, Jelonek L, Dieckmann MA, Beyvers S, Blom J, Goesmann A. (2021). Bakta: rapid and standardized annotation of bacterial genomes via a comprehensive database. *Microbial Genomics* 7(11).
DOI: [10.1099/mgen.0.000685](https://doi.org/10.1099/mgen.0.000685)

**Panaroo**
Tonkin-Hill G, MacAlasdair N, Ruis C, Weimann A, Horesh G, Lees JA, Croucher NJ, Carter R, Flasche S, Parkhill J, Bentley SD, Corander J, Coll F. (2020). Producing polished prokaryotic pangenomes with the Panaroo pipeline. *Genome Biology* 21(180).
DOI: [10.1186/s13059-020-02090-4](https://doi.org/10.1186/s13059-020-02090-4)

**fastBAPS**
Tonkin-Hill G, Lees JA, Bentley SD, Parkhill J, Corander J. (2019). Fast hierarchical Bayesian analysis of population structure. *Wellcome Open Research* 4(69).
DOI: [10.12688/wellcomeopenres.15061.1](https://doi.org/10.12688/wellcomeopenres.15061.1)
