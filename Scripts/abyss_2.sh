#!/usr/bin/python

import os

files = os.listdir("/home/groupc/files/genome_assembly/QC/fastP_output/150bp")
forward = ""
backward = ""
count = 0
for sample in files:
    if sample[-11:] == "_1_fastP.fq" and count == 0:
        forward = sample
        count += 1
        print("FORWARD: " + forward)
    if sample[-11:] == "_2_fastP.fq" and count == 1:
        backward = sample
        count += 1
        print("BACKWARD: " + backward)
    if count == 2:
        name = forward[:7]
        os.system("abyss-pe name=" + name + " k=73 B=4G in='/home/groupc/files/genome_assembly/QC/fastP_output/150bp/" + forward + " /home/groupc/files/genome_assembly/QC/fastP_output/150bp/" + backward + "'")
        count = 0
        forward = ""
        backward = ""
