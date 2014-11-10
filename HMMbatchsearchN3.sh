#! /bin/bash
# Author: Jed Barlow
# Updates by: Christen Klinger
# Last Modified: November 9, 2014
# PBS -l nodes=1,walltime=120:00:00

# Prepend for output filenames
OUTPUTFILE='output'
FASTADIR=/home/cklinger/batch_search_database
QUERYDIR=/home/cklinger/batch_search_queries
now=$(date +"%Y%m%d")

date
echo $HOSTNAME
echo "Starting batch of hmm searches"

# Automatically find hmm file to use
HMMFILE=`ls $QUERYDIR/*.hmm`
echo "Using hmm files:"
echo "$HMMFILE"
echo

# Automatically find data files to use
DATAFILE=`ls $FASTADIR/*.fa`
echo "Using data files:"
echo "$DATAFILE"
echo

for file in $DATAFILE; do
    db_short_name=$(basename "$file")
    db_short_name="${db_short_name%.*}"

    for query in $HMMFILE; do
        q_short_name=$(basename "$query")
        q_short_name="${q_short_name%.*}"

		mkdir -p /home/cklinger/"HMMer_$q_short_name"
		
		hmmsearch -E 0.5 --tblout "HMMer_$q_short_name/${q_short_name}_${db_short_name}_${now}.outfile.txt" "$query" "$file"
	done
done

##End Script
