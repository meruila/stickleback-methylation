#! /bin/bash

########################################
# Extract SRA files using fasterq-dump #
########################################

# Note that this will take up more than 100GB disk space if using all Artemov reads run locally.

ARGUMENTS=4
FORCE_EXIT=65

# Change toolkit to SRA Toolkit location
TOOLKIT=/home/tofumeow/Software/sratoolkit.3.0.0-ubuntu64/bin

if [ $# -ne "$ARGUMENTS" ]
then
  echo "Looking for two arguments: -d and -r"
  exit $FORCE_EXIT
fi

# checking -d/--dir and -r/--reads options
while [ "$1" != "" ]; do
  case $1 in
    -d | --dir )
      shift
      READS_LOCATION="$1"
      ;;
    -r | --reads )
      shift
      SRA_READS="$1"
      ;;
    * )
      echo "Unknown argument: $1"
      exit 1
  esac
  shift
done

mkdir -p fastq_reads

for r in $(cat $SRA_READS)
do
    SRA_ID=${r##*/}
    $TOOLKIT/fasterq-dump.3.0.0 --outdir fastq_reads --skip-technical -x $READS_LOCATION/$SRA_ID
done

# Command used: ./02-fasterq_dump.sh -r reads.txt -d ../reads