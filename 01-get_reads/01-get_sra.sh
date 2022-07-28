#! /bin/bash

###########################
# Retrieve reads from SRA #
###########################
ARGUMENTS=4
FORCE_EXIT=65
PWD=$(pwd)/
echo $PWD
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

# if reads is in current directory, change READS string to PWD + READS
if [[ -f "${PWD}${READS}" ]]
then
    READS=${PWD}${READS}
fi

# directory where to put the downloaded SRA files
mkdir -p $DIR
cd $DIR

if [[ "${READS: -4}" == ".txt" ]]
then
    for r in $(cat $READS)
    do
        echo "Downloading: ${r}"
        wget ${r}
    done
else
    echo "Reads file should end with .txt"
fi

# ./01-get_sra.sh --reads reads.txt --dir ../reads