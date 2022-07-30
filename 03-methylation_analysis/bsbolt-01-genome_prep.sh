#! /bin/bash

###################################
# Genome preparation using BSBolt #
###################################

ARGUMENTS=4
FORCE_EXIT=65

if [ $# -ne "$ARGUMENTS" ]
then
  echo "Looking for two arguments: -g/--genome and -o/--output"
  exit $FORCE_EXIT
fi

while [ "$1" != "" ]; do
  case $1 in
    -g | --genome )
      shift
      GENOME="$1"
      ;;
    -o | --output )
      shift
      OUTPUT_DIRECTORY="$1"
      ;;
    * )
      echo "Unknown argument: $1"
      exit $FORCE_EXIT
  esac
  shift
done

python3 -m bsbolt Index -G $GENOME -DB $OUTPUT_DIRECTORY

# Command used: 