#!/bin/bash
##This is a RAxML script
##These commands set up the Grid Environment for your job:
#PBS -N RAxML
#PBS -l nodes=1,walltime=120:00:00
#PBS -q default
#PBS -M cklinger@ualberta.ca
#PBS -m abe

# Concerning the above code,
# Author: Unknown
#######################################
# Concerning the remainder of this file,
# Author: Christen Klinger
# Created: December 11, 2014


# Info helpful for debugging
echo "Hostname is " $HOSTNAME
pwd
date

QUERY_DIR=/home/cklinger/RAxML
now=$(date +"%Y%m%d")

# Automatically find query files to use
QUERYFILES=`ls $QUERY_DIR/*.phy`
echo "Using query files:"
echo "$QUERYFILES"
echo

for query in $QUERYFILES; do
    ##send RAxML command to Cluster nodes
    raxmlHPC-HYBRID-SSE3 -n result -s "$query" -m PROTCATLG -N 100 -c 25 -p 12345 -b 12345 -T 10
done

##End Script
