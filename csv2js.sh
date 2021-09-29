#!/bin/bash
#
INPUT_FILE=""
OUTPUT_FILE=""
LASTLINE=""

show_usage(){
  echo ""
  echo "Usage:"
  echo "    csv2js.sh -i=INPUTFILE -o=OUTPUTFILE"
  echo ""
  echo "This utility assumes the .csv file is a single column"
  echo "This utility will overwrite OUTPUTFILE"
  echo ""
  exit
}

parse_file(){
  LL="$(tail -n 1 $INPUT_FILE)"
  ctrlm=$(printf "\x$(printf %x 13)")
  if [ "$LL" == "" ] || [ "$LL" == "$ctrlm" ]; then
    LASTLINE="$(tail -n 2 $INPUT_FILE | head -n 1)"
  else
    LASTLINE="$(tail -n 1 $INPUT_FILE)"
  fi
  #LASTLINE=${LASTLINE//[$'\t\r\n']} && LASTLINE=${LASTLINE%%*( )}
  echo "module.exports.blockedSignupDomains"$(date +"%m%d%Y")" = [" > $OUTPUT_FILE
  while IFS= read line || [ -n "$line" ];
  do
    INPUT=${line//[$'\t\r\n']} && INPUT=${INPUT%%*( )}
    if [ ${INPUT: -1} = "," ]; then
      INPUT=${INPUT::-1}
    fi
    if [ ${INPUT: -1} = "\"" ]; then
      INPUT=${INPUT::-1}
    fi
    if [ ${INPUT::1} = "\"" ]; then
      INPUT=${INPUT:1}
    fi
    #echo "${#LASTLINE} $LASTLINE - ${#line} $line"
    if [ "$LASTLINE" = "$line" ]; then
      echo "  '$INPUT'" >> $OUTPUT_FILE
      break
    else
      echo "  '$INPUT'," >> $OUTPUT_FILE
    fi
  done < "$INPUT_FILE"
  echo "]" >> $OUTPUT_FILE
}
  
  if [ $# -eq 0 ]; then
    show_usage
  fi
  for i in "$@"; do
    case $i in
      -i=*|--inputfile=*)
      INPUT_FILE="${i#*=}"
      ;;
      -o=*|--outputfile=*)
      OUTPUT_FILE="${i#*=}"
      ;;
      *)
      # unknown option
      show_usage
      ;;
    esac
  done
  if [[ "$INPUT_FILE" = "$OUTPUT_FILE" ]]; then
    echo ""
    echo "Input and Output filenames should differ"
    echo ""
    exit
  fi
  if [ ! -f "$INPUT_FILE" ]; then
    echo ""
    echo "$INPUT_FILE does not exist."
    echo "Cancelling..."
    echo ""
    show_usage
  fi
  if [ -f "$OUTPUT_FILE" ]; then
    echo ""
    echo "$OUTPUT_FILE exists and will be overwritten."
    echo ""
    echo "CTRL-C to break out"
    read -p "Press ENTER to continue"
  fi


  parse_file

