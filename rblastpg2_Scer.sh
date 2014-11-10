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
# Last Modified: July 25, 2012


# Info helpful for debugging
echo "Hostname is " $HOSTNAME
pwd
date

QUERY_SUB_DIR=/home/bioinfor1/cklinger/BLAST_SEARCHES/rblastpqueries_Scer
DATABASE_SUB_DIR=/home/bioinfor1/cklinger/BLAST_SEARCHES/rblastpdatabase_Scer
BLAST_OPTIONS="-word_size 3 -gapopen 11 -gapextend 1 -evalue 0.05"

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

	mkdir -p /home/bioinfor1/cklinger/"rblastp_$db_short_name"

        ##send BLAST command to Cluster nodes
        blastp -query "$query" -db "$database" -out "rblastp_$db_short_name/${q_short_name}_${db_short_name}.outfile.txt" -outfmt "6 qseqid sseqid evalue"  $BLAST_OPTIONS
    done
done

##End Script
