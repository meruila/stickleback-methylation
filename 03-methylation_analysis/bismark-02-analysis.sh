#! /bin/bash

####################################################
# Alignment and methylation analysis using Bismark #
####################################################

ARGUMENTS=2
FORCE_EXIT=65
BISMARK_LOCATION="/home/tofumeow/Documents/UPLB/Y3SM/Tools/Bismark-0.22.3/"


# analysis using paired-end reads from stickleback
$BISMARK_LOCATION/bismark $1 -1 $2 -2 $3

# there is a deduplicate reads step in Bismark but we do not use this since
# the study uses a reduced representation library
# $BISMARK_LOCATION/deduplicate_bismark --bam $1

$BISMARK_LOCATION/bismark_methylation_extractor $BAM

# for rds in $(ls $reads/*$R1_ID*)
#   do
#     FILE_W_EXT=${rds#$READS_LOCATION/}
#     FILENAME=${FILE_W_EXT%$R1_ID$EXT}
#     read1=$rds
#     read2=$READS_LOCATION/$FILENAME$R2_ID$EXT
#     ./02-paired_bismark.sh $genome $read1 $read2

#     BAM=${FILENAME}_bismark_bt2.bam
#     ./03-deduplicate.sh $BAM

#     ./04-methylation_extractor.sh $genome $BAM
#   done

$BISMARK_LOCATION/bismark2report
$BISMARK_LOCATION/bismark2summary