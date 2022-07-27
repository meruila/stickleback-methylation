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

if [[ -f "${PWD}${READS}" ]]
then
    READS=${PWD}${READS}
fi

mkdir -p $DIR
cd $DIR

if [[ "${READS: -4}" == ".txt" ]]
then
    cat $READS | while read r
    do
        wget ${r}
    done
else
    echo "Reads file should end with .txt"
fi