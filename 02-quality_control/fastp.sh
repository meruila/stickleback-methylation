#! /bin/bash

################################
# Quality control using Fastp  #
################################

ARGUMENTS=2
FORCE_EXIT=65
# Location of Fastp tool
FASTP_LOCATION="/home/tofumeow/Software/"
# Uncomment if running separately
# EXT=".fastq"
# R1_ID="_1"
# R2_ID="_2"
# OUTPUT_EXT=".cleaned"

if [ $# -lt "$ARGUMENTS" ]
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
    * )
      echo "Unknown argument: $1"
      exit 1
  esac
  shift
done

mkdir -p ./{fastp_html,fastp_json,fastp_bin}

for r in $(ls $READS_LOCATION*$R1_ID$EXT)
do
    FILE_W_EXT=${r#$READS_LOCATION}
    FILENAME=${FILE_W_EXT%$R1_ID$EXT}
    in1=$r
    in2=$READS_LOCATION/$FILENAME$R2_ID$EXT
    out1=./fastp_bin/$FILENAME$R1_ID$OUTPUT_EXT
    out2=./fastp_bin/$FILENAME$R2_ID$OUTPUT_EXT
    result=./fastp_html/$FILENAME.html
    result_json=./fastp_json/$FILENAME.json
    $FASTP_LOCATION/fastp --qualified_quality_phred 30 --length_required 75 --in1 $in1 --in2 $in2 --out1 $out1 --out2 $out2 --html $result --json $result_json
done

# Command used: ./fastp.sh -r ../01-get_reads/fastq_reads/