#!/usr/bin/env bash
# Pangenome analysis using Panaroo
# Usage: bash 02_panaroo_analysis.sh
# NOTE: Set paths to match your dataset location in your system

# stops script on error, undefined variable or pipeline failure
set -euo pipefail

#for non-standard GFF3 files, profile the input file as a list in a text file https://gthlab.au/panaroo/#/gettingstarted/quickstart
ls bakta_output/*/*.gff3 > gff3_input.txt

#Directories 
OUTPUT_DIR="panaroo_out"
LOG_DIR="panaroo_logs"
THREADS=8

#create log directory
mkdir -p "${LOG_DIR}"

#panaroo analysis
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting Panaroo pangenome analysis"

panaroo \
    -i gff3_input.txt \
    -o "${OUTPUT_DIR}" \
    --clean-mode sensitive \
    --remove-invalid-genes \
    -a core \
    --core_threshold 0.95 \
    -t "${THREADS}" \
    > "${LOG_DIR}/panaroo.log" 2>&1

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Panaroo finished"
