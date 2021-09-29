#!/bin/bash
#
./csv2js.sh -i=nocommaquotes.csv -o=nocommaquotes.out
./csv2js.sh -i=commasonly.csv -o=commasonly.out
./csv2js.sh -i=commas-n-quotes.csv -o=commas-n-quotes.out
./csv2js.sh -i=emptylineatend.csv -o=emptylineatend.out
tail *.out
