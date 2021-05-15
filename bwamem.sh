#!/bin/bash
# set up iexec directories

mkdir iexec_out
mkdir iexec_in
# get input fastq file locations from environment

# get args for bwamem

args=$1
echo $1

# run bwamem using args
cd iexec_out
../bwa-0.7.17/bwakit/run-bwamem $args -H ../hs38.fa $IEXEC_INPUT_FILE_NAME_1 $IEXEC_INPUT_FILE_NAME_2

# find location of a bam file
bamfile=$(ls *.bam | tail -n 1)

# hash the bam file
hash=`md5sum $bamfile | awk '{ print $1 }'`

# create the proof of computation
touch iexec_out/result.txt
echo $hash\n >> iexec_out/result.txt
echo "{"deterministic-output-path" : "/iexec_out/result.txt"}" > iexec_out/computed.json
