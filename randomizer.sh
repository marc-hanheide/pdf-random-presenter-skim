#!/bin/bash

NUMBER_PAGES=10


home_dir=`dirname $0`

while getopts "hn:" opt; do
  case ${opt} in
    h )
      echo "Usage:"
      echo " -h 	Display this help message."
      echo " -n 	number of pages (default: 10)"
      exit 0
      ;;
    n )
      NUMBER_PAGES="$OPTARG"
      ;;
    \? )
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

PDF="$1"

NUMBER_PAGES=`pdfinfo "$PDF" | grep Pages | tr -s " " | cut -f2 -d" "`

order=`seq 1 1 $NUMBER_PAGES | gshuf`

echo $order

for p in $order; do
 	echo "jump to page $p"
 	osascript gotopage.scpt "$PDF" "$p"
 	read
done
