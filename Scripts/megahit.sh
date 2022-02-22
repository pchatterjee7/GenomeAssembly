#!/usr/bin/python

# Importing packages
import os

# Separate forward and backward strands for 150 bp
forward1 = ""
backward1 = ""
count1 = 0
total_150 = 0
files1 = os.listdir("/home/groupc/files/genome_assembly/QC/fastP_output/150bp")
for sample in files1:
    if "_1_fastP.fq.gz" in sample and count1 == 0:
        forward1 = sample
        count1 += 1
    if "_2_fastP.fq.gz" in sample and count1 == 1:
        backward1 = sample
        count1 += 1
    if count1 == 2:
        output_name = "MEGA_" + forward1[0:7]
        if os.path.exists("/home/groupc/files/genome_assembly/megahit/" + output_name) == True:
            os.system("rm -r /home/groupc/files/genome_assembly/megahit/" + output_name)
        os.system("megahit -1 /home/groupc/files/genome_assembly/QC/fastP_output/150bp/" + forward1 + " -2 /home/groupc/files/genome_assembly/QC/fastP_output/150bp/" + backward1 + " -o " + output_name)
        os.system("mv " + output_name + " /home/groupc/files/genome_assembly/megahit/")
        forward1 = ""
        backward1 = ""
        count1 = 0
        total_150 += 1

# Separate forward and backward strands for 250bp
forward2 = ""
backward2 = ""
count2 = 0
total_250 = 0
files2 = os.listdir("/home/groupc/files/genome_assembly/QC/fastP_output/250bp")
for sample in files2:
    if "_1_fastP.fq.gz" in sample and count2 == 0:
        forward2 = sample
        count2 += 1
    if "_2_fastP.fq.gz" in sample and count2 == 1:
        backward2 = sample
        count2 += 1
    if count2 == 2:
        output_name = "MEGA_" + forward2[0:7]
        if os.path.exists("/home/groupc/files/genome_assembly/megahit/" + output_name) == True:
            os.system("rm -r /home/groupc/files/genome_assembly/megahit/" + output_name)
        os.system("megahit -1 /home/groupc/files/genome_assembly/QC/fastP_output/250bp/" + forward2 + " -2 /home/groupc/files/genome_assembly/QC/fastP_output/250bp/" + backward2 + " -o " + output_name)
        os.system("mv " + output_name + " /home/groupc/files/genome_assembly/megahit/")
        forward2 = ""
        backward2 = ""
        count2 = 0
        total_250 += 1
print("150 total is " + str(total_150))
print("250 total is " + str(total_250))