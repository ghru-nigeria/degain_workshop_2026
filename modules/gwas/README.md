# Bacterial Genome-Wide Association Studies

## Aim

To equip participants with the knowledge and practical skills required to perform bacterial genome-wide association studies (GWAS) to identify genetic variants associated with phenotypes of interest, with applications in antimicrobial resistance (AMR) surveillance, vaccine development, diagnostic target discovery, and precision microbiology.

## Learning Objectives

By the end of this tutorial, participants should be able to:
1.	Explain the fundamental principles of bacterial genome-wide association studies (GWAS), including the different types of genetic variants (e.g., SNPs, genes, k-mers, and unitigs) and phenotypes that can be analysed. 
2.	Select the most appropriate genetic variant type(s) and GWAS approach to address a given biological or research question. 
3.	Describe the complete bacterial GWAS workflow, from study design and data collection through variant generation, association analysis, and post-GWAS interpretation and validation of significant loci. 
4.	Recognise the importance of high-quality genomic and phenotypic data, and evaluate how data quality influences the reliability and reproducibility of GWAS results. 
5.	Identify major sources of confounding in bacterial GWAS, including population structure, linkage disequilibrium, and multiple testing, and explain the methods commonly used to account for these factors. 
6.	Perform a bacterial GWAS using publicly available software (e.g., pyseer), including the preparation of input data, generation of genetic variants (genes, SNPs, k-mers, and unitigs), execution of the association analysis, and interpretation of GWAS outputs, including Manhattan plots, Q-Q plots, and significant genetic associations. 

## Relevant Information

1. Dataset used for the demo session was downloaded from the [pyseer tutorial dataset page](https://figshare.com/articles/dataset/pyseer_tutorial/7588832?file=14091179). Relevant information can be gleaned from the [pyseer tutorial webpage](https://pyseer.readthedocs.io/en/master/tutorial.html).
2. Dataset used for the practical session is not yet publicly available.
3. The following tools should be downloaded beforehand: pyseer, fsm-lite, and unitig-caller.
Alternatively, the following command can be used to install all required tools within a conda environment
```bash
   conda create -f pyseer_env.yml
```

## Questions?

Open an issue on [GitHub](https://github.com/ghru-nigeria/degain_workshop_2026/issues).