#!/bin/bash
#processALLyears.sh


# Description:
#  This script loops over all years in the datafile and calls
    # process311.R each time

for filename in data/*csv
do
    Rscript process311.R $filename
done
