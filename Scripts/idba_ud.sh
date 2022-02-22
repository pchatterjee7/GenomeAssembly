#!/bin/bash

# go to working directory
cd /home/groupc/files/genome_assembly/idba_ud
# Start anaconda env
conda activate team3_genome_assembly

# idba_ud

# take the gz files and uncompress them for fq2fa (which only takes uncompressed files....)
for i in `ls -1 ../QC/fastP_output/150bp/*_fastP.fq.gz | sed 's/_fastP.fq.gz//'`; do \
    gzip -dc ${i}_fastP.fq.gz > ../QC/fastP_output/150bp/${i##*/}\_fastP.fq;done

for i in `ls -1 ../QC/fastP_output/250bp/*_fastP.fq.gz | sed 's/_fastP.fq.gz//'`; do \
    gzip -dc ${i}_fastP.fq.gz > ../QC/fastP_output/250bp/${i##*/}\_fastP.fq;done

# make a directory so you can store the fasta files once you make them
mkdir fasta/
cd fasta/
mkdir 150bp 250bp

# make the fastq into fasta files and interleave them (thats the input type idba-ud accepts)
# were going to do the 150 and 250 separately because idba-us maxk can be adjusted based on the read length.
for i in `ls -1 ../../QC/fastP_output/150bp/*_1_fastP.fq | sed 's/_1_fastP.fq//'`; do \
    fq2fa --merge ${i}_1_fastP.fq ${i}_2_fastP.fq ./150bp/${i##*/}\_12.fas; done

for i in `ls -1 ../../QC/fastP_output/250bp/*_1_fastP.fq | sed 's/_1_fastP.fq//'`; do \
    fq2fa --merge ${i}_1_fastP.fq ${i}_2_fastP.fq ./250bp/${i##*/}\_12.fas; done

# make a directory so you can store the assemblies files once you make them
cd ..
mkdir assemblies
cd assemblies
mkdir 150bp 250bp

# assembly time! 
# details on the specifications:
# -r <interleaved.fas> is the file that we are assembling
# -o <output> is the output file 
# --mink arg default is 20 but we do 21 for uneven k
# --maxk arg default is 100 but the best practice is to give the smallest read length we have. Our reads are all 150 or 250 so ill 
give them 9 less (so 20 step works)
# --step arg default is 20, which seems reasonable.
# --min_contig arg default is 200, which seems reasonable.
# you can but dont need to specify the number of threads. It will assess how many it has access to and do that!
for i in `ls -1 ../fasta/150bp/*_12.fas | sed 's/_12.fas//'`; do \
    idba_ud -r ${i}_12.fas -o ./150bp/${i##*/}\_idba_contigs_19_139_10_min300 --mink 23 --maxk 143 --step 10 --min_contig 300; done

for i in `ls -1 ../fasta/250bp/*_12.fas | sed 's/_12.fas//'`; do \
    idba_ud -r ${i}_12.fas -o ./250bp/${i##*/}\_idba_contigs_43_238_15_min500 --mink 43 --maxk 238 --step 15 --min_contig 500; done


# move all assemblies to one folder.
mkdir idba_contig
for i in `ls -1 assemblies/150bp/ | sed 's/_idba_contigs_19_139_10_min300//'`; do \
    cp assemblies/150bp/${i}_idba_contigs_19_139_10_min300/contig.fa idba_contig/${i##*/}\_contig.fa;done

for i in `ls -1 assemblies/250bp/ | sed 's/_idba_contigs_43_238_15_min500//'`; do \
    cp assemblies/250bp/${i}_idba_contigs_43_238_15_min500/contig.fa idba_contig/${i##*/}\_contig.fa;done


# DONE
