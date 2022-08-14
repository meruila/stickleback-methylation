#! /bin/bash

#########################################################
# Wrapper script for alignment and methylation analysis #
#########################################################

ARGUMENTS_INTERFACE=1
ARGUMENTS_CMDLINE=5
FORCE_EXIT=65

GENOME=""
OUTPUT_DIRECTORY=""
READS_LOCATION=""
EXT=".fastq"
R1_ID="_1"
R2_ID="_2"
IS_BISMARK=-1
BISMARK_INTERFACE=0
BSBOLT_INTERFACE=0
bsm="--bismark_interface"
bsb="--bsbolt_interface"

if (($# < "$ARGUMENTS_INTERFACE"))
then
  echo "Looking for three arguments: -g/--genome, -r/--rloc, and --bismark or --bsbolt"
  echo "To use the interface enter --bismark_interface or --bsbolt_interface"
  exit $FORCE_EXIT
fi

if (($# < "$ARGUMENTS_CMDLINE"))
then
  if [ "$1" != "$bsm" ] && [ "$1" != "$bsb" ]
  then
    echo "Looking for three arguments: -g/--genome and -r/--rloc, and --bismark or --bsbolt"
    exit $FORCE_EXIT
  fi
fi

while [ "$1" != "" ]; do
  case $1 in
    --bismark_interface )
      BISMARK_INTERFACE=1
      ;;
    --bsbolt_interface )
      BSBOLT_INTERFACE=1
      ;;
    -g | --genome )
      shift
      GENOME="$1"
      ;;
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
    --bismark )
      IS_BISMARK=1
      ;;
    --bsbolt )
      IS_BSBOLT=0
      ;;
    * )
      echo "Unknown argument: $1"
      exit 1
  esac
  shift
done

if [[ $BISMARK_INTERFACE == 1 ]]
then
  echo "Enter genome directory: "
  read GENOME
  echo "Enter reads directory: "
  read READS_LOCATION
  echo "Enter reads extension (e.g. .fastq, .fq): "
  read EXT
  echo "Enter read1 identifier (e.g. _1): "
  read R1_ID
  echo "Enter read2 identifier (e.g. _2): "
  read R2_ID

  ./bismark-01-genome_prep.sh -g $GENOME
  ./bismark-02-analysis.sh -g $GENOME -r $READS_LOCATION -e $EXT --r1 $R1_ID --r2 $R2_ID
elif [[ $BSBOLT_INTERFACE == 1 ]]
then 
  echo "Enter genome file: "
  read GENOME
  echo "Enter output directory of genome preparation"
  read OUTPUT_DIRECTORY
  echo "Enter reads directory: "
  read READS_LOCATION
  echo "Enter reads extension (e.g. .fastq, .fq): "
  read EXT
  echo "Enter read1 identifier (e.g. _1): "
  read R1_ID
  echo "Enter read2 identifier (e.g. _2): "
  read R2_ID

  ./bsbolt-01-genome_prep.sh -g $GENOME -o $OUTPUT_DIRECTORY
  ./bsbolt-02-analysis.sh -g $OUTPUT_DIRECTORY -r $READS_LOCATION -e $EXT --r1 $R1_ID --r2 $R2_ID
fi

if [[ $IS_BISMARK == 1 ]]
then
  ./bismark-01-genome_prep.sh -g $GENOME
  ./bismark-02-analysis.sh -g $GENOME -r $READS_LOCATION -e $EXT --r1 $R1_ID --r2 $R2_ID
elif [[ $IS_BSBOLT == 1 ]]
then
  ./bsbolt-01-genome_prep.sh -g $GENOME -o $OUTPUT_DIRECTORY
  ./bsbolt-02-analysis.sh -g $OUTPUT_DIRECTORY -r $READS_LOCATION -e $EXT --r1 $R1_ID --r2 $R2_ID
fi

# Command used: ./00-main.sh --bismark_interface
# Alternate command used: ./00-main.sh -g /home/tofumeow/Documents/UPLB/Y3SM/reference-genome/Gasterosteus_aculeatus -r /media/tofumeow/Potato/Bioinformatics/stickleback_runs/fastp_paired_end/fastp_bin -e .cleaned.fastq --r1 _1 --r2 _2 --bismark