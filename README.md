# csv2js.sh convert .csv to .js (JSON)

Prerequisite:
 - The input csv file must exist
 - The input csv file must contain only one column

Notes:
 - Accepts with or without commas and/or double quotes
 - Can deal with 1 empty line at the end of the csv (but not more than 1)

Usage:
    csv2js.sh -i=INPUTFILE -o=OUTPUTFILE

This utility assumes the .csv file is a single column

This utility will overwrite OUTPUTFILE
