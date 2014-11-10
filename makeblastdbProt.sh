#!/bin/bash
##This is an example script MAKEBLASTDB.sh
##These commands set up the Grid Environment for your job:
#PBS -N makeblastdb_Prot
#PBS -l nodes=1,walltime=12:00:00
#PBS -q batch
#PBS -M cklinger@ualberta.ca
#PBS -m abe
##Print the Host name of Node
echo "Hostname is " $HOSTNAME
##print the time and date
##Print  working Direcitory
pwd
##Print Date
date

# Automatically find data file to use
DATAFILE=`ls /home/bioinfor1/cklinger/MAKEBLASTDB/*.fa`
echo "Using query file $DATAFILE"

##send MAKEBLASTDB command to Cluster nodes
makeblastdb -in "$DATAFILE" -dbtype prot
##End Script
