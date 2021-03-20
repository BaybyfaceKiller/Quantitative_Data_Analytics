#!/bin/bash
#count_Sept_births.sh
sept_count=$(grep /09 ${1}/* | wc -l)
echo "The number of subjects born in September is $sept_count."
