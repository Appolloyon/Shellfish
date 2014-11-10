#!/bin/bash
##This is a BLAST script
##These commands set up the Grid Environment for your job:
#PBS -N  jobname
#PBS -l nodes=1,walltime=12:00:00
#PBS -q batch
#PBS -M email
#PBS -m abe

# Concerning the above code,
# Author: Unknown
#######################################
# Concerning the remainder of this file,
# Author: Jed Barlow
# Author: Lael Barlow
# Updates by: Christen Klinger
# Last Modified: November 10, 2014


# Info helpful for debugging
echo "Hostname is " $HOSTNAME
pwd
date

QUERY_SUB_DIR=/home/cklinger/BLAST_SEARCHES/rblastpqueries_Hsap
DATABASE_SUB_DIR=/home/cklinger/BLAST_SEARCHES/rblastpdatabase_Hsap
BLAST_OPTIONS="-word_size 3 -gapopen 11 -gapextend 1 -evalue 0.1"
now=$(date +"%Y%m%d")

# Automatically find query files to use
QUERYFILES=`ls $QUERY_SUB_DIR/*.fa`
echo "Using query files:"
echo "$QUERYFILES"
echo

# Automatically find data files to use
DATAFILES=`ls $DATABASE_SUB_DIR/*.fa`
echo "Using data files:"
echo "$DATAFILES"
echo


for database in $DATAFILES; do
    db_short_name=$(basename "$database")
    db_short_name="${db_short_name%.*}"

    for query in $QUERYFILES; do
        q_short_name=$(basename "$query")
        q_short_name="${q_short_name%.*}"

	mkdir -p /home/cklinger/"rblastp_$db_short_name"

        ##send BLAST command to Cluster nodes
        blastp -query "$query" -db "$database" -out "rblastp_$db_short_name/${q_short_name}_${db_short_name}_${now}.outfile.txt" -outfmt "6 qseqid sseqid evalue"  $BLAST_OPTIONS
    done
done

##End Script
