#!/bin/bash
#
# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
input_file=""
output_file=""

while getopts "h?io:" opt; do
  case "$opt" in
    h|\?)
      echo "Help"
      #show_help
      exit 0
      ;;
    i)  input_file=$OPTARG
      ;;
    o)  output_file=$OPTARG
      ;;
  esac
done

shift $((OPTIND-1))
echo "INPUT $input_file"
echo "OUTPUT $output_file"

