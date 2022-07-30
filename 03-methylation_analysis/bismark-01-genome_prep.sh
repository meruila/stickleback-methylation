#! /bin/bash

####################################
# Genome preparation using Bismark #
####################################

ARGUMENTS=2
FORCE_EXIT=65
BISMARK_LOCATION="/home/tofumeow/Documents/UPLB/Y3SM/Tools/Bismark-0.22.3/"
BOWTIE_LOCATION="/home/tofumeow/Documents/UPLB/Y3SM/Tools/bowtie2-2.4.4-linux-x86_64/"

if [ $# -ne "$ARGUMENTS" ]
then
  echo "Looking for one argument: -g/--genome"
  exit $FORCE_EXIT
fi

while [ "$1" != "" ]; do
  case $1 in
    -g | --genome )
      shift
      GENOME_DIRECTORY="$1"
      ;;
    * )
      echo "Unknown argument: $1"
      exit $FORCE_EXIT
  esac
  shift
done

${BISMARK_LOCATION}bismark_genome_preparation --path_to_aligner $BOWTIE_LOCATION --verbose $GENOME_DIRECTORY

# Command used: ./bismark-01-genome_prep.sh -g /home/tofumeow/Documents/UPLB/Y3SM/reference-genome/Gasterosteus_aculeatus