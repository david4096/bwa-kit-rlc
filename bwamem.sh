#!/bin/bash
# set up iexec directories

mkdir -p iexec_out
mkdir -p iexec_in
# get input fastq file locations from environment

# get args for bwamem
args=$1
command="../bwa-0.7.17/bwakit/run-bwamem $args -H hs38.fa ../iexec_in/$IEXEC_INPUT_FILE_NAME_1 ../iexec_in/$IEXEC_INPUT_FILE_NAME_2"
echo "Executing bwa-mem with command line..."
echo $command

# run bwamem using args
cd iexec_out
$command

# find location of a bam file
bamfile=$(ls *.bam | tail -n 1)

# hash the bam file
hash=`md5sum $bamfile | awk '{ print $1 }'`
cd ..
# create the proof of computation
touch iexec_out/result.txt
echo $hash >> iexec_out/result.txt
echo "{"deterministic-output-path" : "/iexec_out/result.txt"}" > iexec_out/computed.json
