#! /bin/bash

################################
# Quality control using Fastp  #
################################

ARGUMENTS=2
FORCE_EXIT=65
# Location of Fastp tool
FASTP_LOCATION="/home/tofumeow/Software/"
# Uncomment if running separately
EXT=".fastq"
OUTPUT_EXT=".cleaned.fastq"

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

mkdir -p ./{fastp_html_single,fastp_json_single,fastp_bin_single}

for r in $(ls $READS_LOCATION*$EXT)
do
    FILE_W_EXT=${r#$READS_LOCATION}
    FILENAME=${FILE_W_EXT%$EXT}
    in1=$r
    out1=./fastp_bin_single/$FILENAME$R1_ID$OUTPUT_EXT
    result=./fastp_html_single/$FILENAME.html
    result_json=./fastp_json_single/$FILENAME.json
    $FASTP_LOCATION/fastp --qualified_quality_phred 30 --length_required 75 --trim_front1=15 --trim_tail1=3 --in1 $in1 --out1 $out1 --html $result --json $result_json
done

# COmmand used: ./fastp_single-end.sh -r ../01-get_reads/fastq_reads_single/