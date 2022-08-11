#! /bin/bash

####################################################
# Alignment and methylation analysis using Bismark #
####################################################

ARGUMENTS=4
FORCE_EXIT=65
BISMARK_LOCATION="/home/tofumeow/Documents/UPLB/Y3SM/Tools/Bismark-0.22.3/"
BOWTIE_LOCATION="/home/tofumeow/Documents/UPLB/Y3SM/Tools/bowtie2-2.4.4-linux-x86_64/"
SAMTOOLS_LOCATION="/home/tofumeow/Documents/UPLB/Y3SM/Tools/samtools-1.12/"

# Uncomment if running this code separately
R1_ID="_1"
R2_ID="_2"
EXT=".cleaned.fastq"

start=`date +%s`

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

for r in $(ls $READS_LOCATION*$R1_ID$EXT)
  do
    FILE_W_EXT=${r#$READS_LOCATION}
    FILENAME=${FILE_W_EXT%$R1_ID$EXT}
    read1=$r
    read2=$READS_LOCATION$FILENAME$R2_ID$EXT
    # analysis using paired-end reads from stickleback
    $BISMARK_LOCATION/bismark $GENOME_DIRECTORY -1 $read1 -2 $read2 --path_to_bowtie2 $BOWTIE_LOCATION --samtools_path $SAMTOOLS_LOCATION

    # there is a deduplicate reads step in Bismark but we do not use this since
    # the study uses a reduced representation library
    # $BISMARK_LOCATION/deduplicate_bismark --bam $1
    BAM=${FILENAME}_bismark_bt2.bam
    $BISMARK_LOCATION/bismark_methylation_extractor $GENOME_DIRECTORY $BAM --samtools_path $SAMTOOLS_LOCATION --bedGraph
done

$BISMARK_LOCATION/bismark2report
$BISMARK_LOCATION/bismark2summary

end=`date +%s`

runtime=$((end-start))
echo $runtime >> run_bismark.txt

# Command used: ./bismark-02-analysis.sh -g /home/tofumeow/Documents/UPLB/Y3SM/reference-genome/Gasterosteus_aculeatus -r /home/tofumeow/Documents/UPLB/Y3SM/stickleback-methylation/01-get_reads/fastq_reads/
# Alternate command used: ./bismark-02-analysis.sh -g /home/tofumeow/Documents/UPLB/Y3SM/reference-genome/Gasterosteus_aculeatus -r /home/tofumeow/Documents/UPLB/Y3SM/stickleback-methylation/02-quality_control/fastp_bin/ -e .cleaned.fastq --r1 _1 --r2 _2