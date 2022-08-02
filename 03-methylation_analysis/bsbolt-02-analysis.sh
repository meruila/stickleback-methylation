#! /bin/bash

#####################################
# Methylation analysis using BSBolt #
#####################################

ARGUMENTS=4
FORCE_EXIT=65

# Uncomment if running this code separately
# R1_ID="_1"
# R2_ID="_2"
# EXT=".fastq"

if [ $# -lt "$ARGUMENTS" ]
then
  echo "Looking for two arguments: -g/--genome and -r/--reads"
  exit $FORCE_EXIT
fi

while [ "$1" != "" ]; do
  case $1 in
    -g | --genome )
      shift
      GENOME_DIRECTORY="$1"
      ;;
    -r | --reads )
      shift
      READS_LOCATION="$1"
      ;;
    -e | --ext )
      shift
      EXT="$1"
      ;;
    --r1 )
      shift
      R1_ID="$1"
      ;;
    --r2 )
      shift
      R2_ID="$1"
      ;;
    * )
      echo "Unknown argument: $1"
      exit $FORCE_EXIT
  esac
  shift
done

mkdir -p {bsbolt_bam,bsbolt_mcalls}

for r in $(ls $READS_LOCATION*$R1_ID$EXT)
  do
    FILE_W_EXT=${r#$READS_LOCATION}
    FILENAME=${FILE_W_EXT%$R1_ID$EXT}
    read1=$r
    read2=$READS_LOCATION$FILENAME$R2_ID$EXT
    # analysis using paired-end reads from stickleback
    python3 -m bsbolt Align -DB $GENOME_DIRECTORY -F1 $read1 -F2 $read2 -O ./bsbolt_bam/$FILENAME
    python3 -m bsbolt CallMethylation -I ./bsbolt_bam/$FILENAME.bam -O ./bsbolt_mcalls/ -DB $GENOME_DIRECTORY -t 2 -verbose > methylation_stats$FILENAME.txt
done

# Command used: ./bsbolt-02-analysis.sh -g /home/tofumeow/Documents/UPLB/Y3SM/stickleback-methylation/03-methylation_analysis/genome_prep_outputs -r /home/tofumeow/Documents/UPLB/Y3SM/stickleback-methylation/01-get_reads/fastq_reads/ -e .fastq --r1 _1 --r2 _2