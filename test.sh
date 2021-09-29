#!/bin/bash
#
newline_at_eof()
{
    if [[ -s "$1" && -z "$(tail -c 1 "$1")" ]]
    then
        echo "Newline at end of file!"
    else
        echo "No newline at end of file!"
    fi
}
newline_at_eof emptylineatend.csv
newline_at_eof commasonly.csv

