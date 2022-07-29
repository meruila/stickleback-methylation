#! /bin/bash

###############################################
# Wrapper script for quality control of reads #
###############################################

ARGUMENTS=2
FORCE_EXIT=65

EXT=".fastq"
R1_ID="_1"
R2_ID="_2"
IS_FASTQC=1

if (($# < "$ARGUMENTS"))
then
  echo "Looking for one argument: -r/--rloc"
  exit $FORCE_EXIT
fi

# checking -r/--reads
# Optional parameters
#       1. -e/--ext: for changing extension
#       2. --r1: for changing identifier for read 1
#       3. --r2: for changing identifier for read 2
#       4. --oext: for changing filename extension of output binary files
#       5. --fastp/--fastqc: for choosing which quality control tool to use. FastQC is used as default.
while [ "$1" != "" ]; do
  case $1 in
    -r | --rloc )
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
    --oext )
      shift
      OUTPUT_EXT="$1"
      ;;
    --fastqc )
      IS_FASTQC=1
      ;;
    --fastp )
      IS_FASTQC=0
      ;;
    * )
      echo "Unknown argument: $1"
      exit 1
  esac
  shift
done

if [[ $IS_FASTQC == 1 ]]
then
    ./fastqc.sh -r $READS_LOCATION
else
    ./fastp.sh -r $READS_LOCATION -e $EXT --r1 $R1_ID --r2 $R2_ID --oext $OUTPUT_EXT
fi