#!/bin/bash
# set up iexec directories (they should be there from mounted volumes)
set -o history -o histexpand
mkdir -p iexec_out
mkdir -p iexec_in

# get input fastq file locations from environment
# get args for bwamem
args=$1

# run bwamem using args
cd iexec_out
../bwa-0.7.17/bwa mem $args ../hs38.fa ../iexec_in/$IEXEC_INPUT_FILE_NAME_1 \
 ../iexec_in/$IEXEC_INPUT_FILE_NAME_2 | samtools sort -o output.bam -

# find location of a bam file
bamfile="output.bam"

# hash the bam file
hash=`md5sum $bamfile | awk '{ print $1 }'`
cd ..
# create the proof of computation
touch iexec_out/result.txt
echo $hash >> iexec_out/result.txt
echo "{"deterministic-output-path" : "/iexec_out/result.txt"}" > iexec_out/computed.json
echo "Output files and result.txt written to iexec_out"
