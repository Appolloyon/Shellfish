#!/bin/bash
##This is an example script example.sh
##These commands set up the Grid Environment for your job:
#PBS -N multithread2
#PBS -l nodes=bioinfor3,walltime=4800:00:00
#PBS -q batch
#PBS -M cklinger@ualberta.ca
#PBS -m abe
#print the time and date
echo $HOST
export HHLIB=/usr/lib/hh/lib
date
#run the HHsearch   program
multithread.pl '/home/bioinfor1/cklinger/TgonDB2/*.seq' 'hhblits -i $file -n 2 -d /home/bioinfor1/cklinger/UniProt2/uniprot20_2013_03 -oa3m $name.a3m' -cpu 16 
#print the time and date again
date
