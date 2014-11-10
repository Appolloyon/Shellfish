#!/bin/bash
##This is an example script example.sh
##These commands set up the Grid Environment for your job:
#PBS -N splitfasta
#PBS -l nodes=bioinfor3,walltime=120:00:00
#PBS -q batch
#PBS -M cklinger@ualberta.ca
#PBS -m abe
#print the time and date
echo $HOST
export HHLIB=/usr/lib/hh/lib
date
#run the HHsearch   program
splitfasta.pl /home/bioinfor1/cklinger/TgonDB/Tgondii.fa -o /home/bioinfor1/cklinger/TgonDB/ | mv ~/*.seq ~/TgonDB
#print the time and date again
date
