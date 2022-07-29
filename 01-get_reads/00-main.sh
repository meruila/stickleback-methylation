#! /bin/bash

###########################################
# Wrapper script for reads pre-processing #
###########################################

ARGUMENTS=4
FORCE_EXIT=65
PWD=$(pwd)/
echo $PWD
if [ $# -ne "$ARGUMENTS" ]
then
  echo "Looking for two arguments: -d/--dir and -r/--reads."
  exit $FORCE_EXIT
fi

# checking -d/--dir and -r/--reads options
while [ "$1" != "" ]; do
  case $1 in
    -d | --dir )
      shift
      DIR="$1"
      ;;
    -r | --reads )
      shift
      READS="$1"
      ;;
    * )
      echo "Unknown argument: $1"
      exit 1
  esac
  shift
done

if [ -z "$DIR" ] || [ -z "$READS" ]
then
    echo "At least one required argument is missing. Looking for two arguments: -d/--dir and -r/--reads."
    exit $FORCE_EXIT
fi

./01-get_sra.sh --reads reads.txt --dir ../reads
./02-fasterq_dump.sh -r reads.txt -d ../reads