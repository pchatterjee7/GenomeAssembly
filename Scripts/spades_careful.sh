#!/bin/bash

#go to working directory
cd /home/groupc/files/genome_assembly/spades

#Start anaconda env
conda activate team3_genome_assembly

#make directory for 150 bp run and 250 bp run
mkdir spades_150bp_run_careful
mkdir spades_250bp_run_careful

#run the spades program for each pair in 150 bp
for i in `ls -1 ../QC/fastP_output/150bp/*_1_fastP.fq.gz | sed 's/_1_fastP.fq.gz//'`
do
	spades.py -k 21,33,55,77  --careful  --pe1-1 ${i}_1_fastP.fq.gz --pe1-2 ${i}_2_fastP.fq.gz -o ./spades_150bp_run_careful/${i##*/};\
done

#run the spades program for each pair in 250 bp
for i in `ls -1 ../QC/fastP_output/250bp/*_1_fastP.fq.gz | sed 's/_1_fastP.fq.gz//'`
do
	spades.py -k 21,33,55,77,99,127  --careful --pe1-1 ${i}_1_fastP.fq.gz --pe1-2 ${i}_2_fastP.fq.gz -o ./spades_250bp_run_careful/${i##*/};\
done

#spades does not save the contigs with the sample name, so give it to add them
for i in `ls -1 ./spades_150bp_run_careful`
do
	mv ./spades_150bp_run_careful/${i}/contigs.fasta ./spades_150bp_run_careful/${i}/${i}_contigs.fasta
done

for i  in `ls -1 ./spades_250bp_run_careful`
do
	mv ./spades_250bp_run_careful/${i}/contigs.fasta ./spades_250bp_run_careful/${i}/${i}_contigs.fasta
done

#grab the contigs files and put them all in one folder

mkdir spades_contigs_all_careful

for i in `ls -1 ./spades_150bp_run_careful`
do
	cp ./spades_150bp_run_careful/${i}/${i}_contigs.fasta ./spades_contigs_all_careful
done

for i in `ls -1 ./spades_250bp_run_careful`
do
        cp ./spades_250bp_run_careful/${i}/${i}_contigs.fasta ./spades_contigs_all_careful
done
