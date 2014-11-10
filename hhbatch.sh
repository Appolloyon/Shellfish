#! /bin/bash
# Author: Chris Klinger
# Last Modified: May 31, 2012

#PBS -N HHbatch
#PBS -l nodes=bioinfor1,walltime=720:00:00
#PBS -q batch
#PBS -M cklinger@ualberta.ca
#PBS -m abe
#print the time and date
echo $HOST
export HHLIB=/usr/lib/hh/lib

# Prepend for output filenames
OUTPUTFILE='output'
QUERYDIR=/home/bioinfor1/cklinger/HHsearch

date
echo $HOSTNAME
echo "Starting batch of hmm searches"

# Automatically find afa file to use
AFAFILE=`ls $QUERYDIR/*.afa`
echo "Using afa files:"
echo "$AFAFILE"
echo

for query in $AFAFILE; do
	q_short_name=$(basename "$query")
	q_short_name="${q_short_name%.*}"

		mkdir -p /home/bioinfor1/cklinger/HH_Output
		
		hhsearch -i "$query" -d /home/bioinfor1/cklinger/UniProt/uniprot20_2012_10_hhm_db -o "HH_Output/${q_short_name}.outfile.txt"
	done
done

##End Script