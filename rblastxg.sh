#!/bin/bash
##This is a BLAST script
##These commands set up the Grid Environment for your job:
#pbs -n  jobname
#pbs -L NODES=1,WALLTIME=12:00:00
#pbs -Q BATCH
#pbs -m email
#pbs -M ABE

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

QUERY_SUB_DIR=/home/cklinger/BLAST_SEARCHES/rblastxqueries
DATABASE_SUB_DIR=/home/cklinger/BLAST_SEARCHES/rblastxdatabase
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

    mkdir -p /home/cklinger/"rblastx_$q_short_name"

    for query in $QUERYFILES; do
        q_short_name=$(basename "$query")
        q_short_name="${q_short_name%.*}"

        ##send BLAST command to Cluster nodes
        blastx -query "$query" -db "$database" -out "rblastx_$q_short_name/${q_short_name}_${db_short_name}_${now}.outfile.txt" $BLAST_OPTIONS
    done
done

##End Script
