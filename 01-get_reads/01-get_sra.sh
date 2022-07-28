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

# directory where to download the SRA files
mkdir -p $DIR
cd $DIR

if [[ "${READS: -4}" == ".txt" ]]
then
    cat $READS | while read r
    do
        echo "Downloading: ${r}"
        wget ${r}
    done
else
    echo "Reads file should end with .txt"
fi