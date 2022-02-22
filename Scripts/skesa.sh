#!/bin/bash

# go to working directory
cd /home/groupc/files/genome_assembly/skesa
# Start anaconda env
conda activate team3_genome_assembly

# SKESA

for i in `ls -1 ../QC/fastP_output/150bp/*_1_fastP.fq | sed 's/_1_fastP.fq//'`; do \
    skesa --fastq ${i}_1_fastP.fq,${i}_2_fastP.fq \
    --cores 8 --memory 50 --kmer 23 --steps 12 \
    --contigs_out ./${i##*/}.skesa.fa;\
    done

for i in `ls -1 ../QC/fastP_output/250bp/*_1_fastP.fq | sed 's/_1_fastP.fq//'`; do \
    skesa --fastq ${i}_1_fastP.fq,${i}_2_fastP.fq \
    --cores 8 --memory 50 --kmer 43 --steps 13 \
    --contigs_out ./${i##*/}.skesa.fa;\
    done
