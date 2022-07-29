#! /bin/bash

################################
# Quality control using FastQC #
################################

ARGUMENTS=2
FORCE_EXIT=65
EXT=".fastq"
R1_ID="_1"
R2_ID="_2"

if [ $# -ne "$ARGUMENTS" ]
then
  echo "Looking for one argument: -r/--rloc"
  exit $FORCE_EXIT
fi

# checking -r/--reads
# Optional parameters
#       1. -e/--ext: for changing extension
#       2. --r1: for changing identifier for read 1
#       3. --r2: for changing identifier for read 2
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
    * )
      echo "Unknown argument: $1"
      exit 1
  esac
  shift
done

mkdir -p fastqc_outputs

for r in $(ls $READS_LOCATION*$R1_ID$EXT)
do
    FILE_W_EXT=${r#$READS_LOCATION/}
    FILENAME=${FILE_W_EXT%$R1_ID$EXT}
    fastqc $FILENAME*$EXT -o fastqc_outputs 
done

for out in ./fastqc_outputs/*.zip 
do
    unzip $out -d fastqc_outputs/ # unzip and direct the output to the fastqc directory
done

# Command used: ./fastqc.sh --rloc ../01-get_reads/fastq_reads/