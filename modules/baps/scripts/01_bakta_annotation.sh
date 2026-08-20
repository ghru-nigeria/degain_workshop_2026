#!/usr/bin/env bash

# bakta_annotation.sh
# genome annotation for Escherchia coli
# Usage: bash 01_bakta_annotation.sh

set -euo pipefail #stops on any error

# --- Directories ---
GENOME_DIR="genomes"
OUTPUT_DIR="bakta_out"
LOG_DIR="logs"
DB="db-light"
THREADS=8

# --- Setup ---
mkdir -p "${LOG_DIR}"

# --- Run Bakta ---
for file in "${GENOME_DIR}"/*.fasta; do
    base=$(basename "$file" .fasta)
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Running Bakta on: ${base}"

    bakta "$file" \
        --db "${DB}" \
        --output "${OUTPUT_DIR}/${base}" \
        --prefix "${base}" \
        --genus Escherichia \
        --species coli \
        --threads "${THREADS}" \
        > "${LOG_DIR}/${base}.log" 2>&1

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished: ${base}"
done

echo "All done"
