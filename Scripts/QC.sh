#!/bin/bash

# go to working directory
cd /home/groupc/files/genome_assembly/QC
# Start anaconda env
conda activate team3_genome_assembly

mv ../../../data/250bp/CGT1121 ../../../data/150bp/CGT1121



# fastqc/multiqc before FastP
mkdir fastQC_on_Original
mkdir multiQC_on_Original

mkdir fastQC_on_Original/150bp
fastqc -o fastQC_on_Original/150bp ../../../data/150bp/*/*.fq.gz
multiqc fastQC_on_Original/150bp
mv multiqc_data multiQC_on_Original/multiqc_results_150bp
mv multiqc_report.html multiQC_on_Original/multiqc_results_150bp.html

mkdir fastQC_on_Original/250bp
fastqc -o fastQC_on_Original/250bp ../../../data/250bp/*/*.fq.gz
multiqc fastQC_on_Original/250bp
mv multiqc_data multiQC_on_Original/multiqc_results_Original_250bp
mv multiqc_report.html multiQC_on_Original/multiqc_results_Originial_250bp.html


# Run FastP
mkdir fastP_output

mkdir fastP_output/150bp
for i in `ls -1 ../../../data/150bp/*/*_1.fq.gz | sed 's/_1.fq.gz//'`; do \
    fastp -i ${i}_1.fq.gz -I ${i}_2.fq.gz \
    -o fastP_output/150bp/${i##*/}\_1_fastP.fq.gz -O fastP_output/150bp/${i##*/}\_2_fastP.fq.gz\
    --correction --cut_front --cut_tail -M 30 --thread 8 -f 5 -q 20 -e 28\
    ;done
    
mv fastp.json fastp_150bp.json
mv fastp.html fastp_150bp.html

mkdir fastP_output/250bp
for i in `ls -1 ../../../data/250bp/*/*_1.fq.gz | sed 's/_1.fq.gz//'`; do \
    fastp -i ${i}_1.fq.gz -I ${i}_2.fq.gz \
    -o fastP_output/250bp/${i##*/}\_1_fastP.fq.gz -O fastP_output/250bp/${i##*/}\_2_fastP.fq.gz\
    --correction --cut_front --cut_tail -M 30 --thread 8 -f 5 -q 20 -e 28\
    ;done
mv fastp.json fastp_250bp.json
mv fastp.html fastp_250bp.html


# fastqc/multiqc after FastP
cd /home/groupc/files/genome_assembly/QC
mkdir fastQC_on_FastP
mkdir multiQC_on_FastP

mkdir fastQC_on_FastP/150bp
fastqc -o fastQC_on_FastP/150bp fastP_output/150bp/*_fastP.fq.gz
multiqc fastQC_on_FastP/150bp
mv multiqc_data multiQC_on_FastP/multiqc_results_fastP_150bp
mv multiqc_report.html multiQC_on_FastP/multiqc_results_fastP_150bp.html



mkdir fastQC_on_FastP/250bp
fastqc -o fastQC_on_FastP/250bp fastP_output/250bp/*_fastP.fq.gz
multiqc fastQC_on_FastP/250bp
mv multiqc_data multiQC_on_FastP/multiqc_results_fastP_250bp
mv multiqc_report.html multiQC_on_FastP/multiqc_results_fastP_250bp.html

# DONE
