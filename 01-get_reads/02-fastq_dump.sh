#! /bin/bash

######################################
# Extract SRA files using fastq-dump #
######################################

SRA_READS=$1
# Change toolkit to SRA Toolkit location
TOOLKIT=/home/tofumeow/Software/sratoolkit.3.0.0-ubuntu64/bin

mkdir fastq_reads

for r in $(cat $SRA_READS)
do
    SRA_ID=${r##*/}
    $TOOLKIT/fasterq-dump.3.0.0 --outdir fastq_reads --skip-technical  --readids --read-filter pass ../reads/$SRA_ID
done