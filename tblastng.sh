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
# Created: July 25, 2012
# Modified: September 8, 2014
# Updated home directory to "/home/bioinfor1/cklinger/"
# to keep consistent with changes to Hydra structure


# Info helpful for debugging
echo "Hostname is " $HOSTNAME
pwd
date

QUERY_SUB_DIR=/home/cklinger/BLAST_SEARCHES/tblastnqueries
DATABASE_SUB_DIR=/home/cklinger/BLAST_SEARCHES/tblastndatabase
BLAST_OPTIONS="-word_size 3 -gapopen 11 -gapextend 1"

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

    mkdir -p /home/cklinger/"tblastn_$db_short_name"

    for query in $QUERYFILES; do
        q_short_name=$(basename "$query")
        q_short_name="${q_short_name%.*}"

        ##send BLAST command to Cluster nodes
        tblastn -query "$query" -db "$database" -out "tblastn_$db_short_name/${q_short_name}_${db_short_name}.outfile.txt" $BLAST_OPTIONS
    done
done

##End Script
