#!/usr/bin/env bash
set -euo pipefail

ITERATION=$1
NOW=$(date "+%y%m%d%H%M")
#echo $NOW

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

REPORT_FILE=$SCRIPT_DIR/reports/data-status-$ITERATION-$NOW.tsv

echo -e "ITERATION:\t$ITERATION"
echo -e "Type\tSubset\tSize"
for dir in $(find $SCRIPT_DIR -maxdepth 1 -iname "*data"); do
  for file in $dir/*.csv; do
     dirname=$(basename $dir | cut -d '_' -f 1)
     filename=$(basename $file | cut -d '.' -f 1)
     size=$(wc -l $file | cut -d ' ' -f 1)
     echo -e "$dirname\t$filename\t$size"
     done;
done | sort > $REPORT_FILE

cat $REPORT_FILE
