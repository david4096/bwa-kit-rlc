#!/bin/bash
# clear the input and output dirs
rm -rf iexec_in
rm -rf iexec_out
# prepare the input data
mkdir -p iexec_in
cd iexec_in
# download example sequence from 1kgenomes
wget https://github.com/hartwigmedical/testdata/raw/master/100k_reads_hiseq/TESTX/TESTX_H7YRLADXX_S1_L001_R1_001.fastq.gz
wget https://github.com/hartwigmedical/testdata/raw/master/100k_reads_hiseq/TESTX/TESTX_H7YRLADXX_S1_L001_R2_001.fastq.gz
gunzip TESTX_H7YRLADXX_S1_L001_R1_001.fastq.gz
gunzip TESTX_H7YRLADXX_S1_L001_R2_001.fastq.gz
cd ../
# prepare output location
mkdir -p iexec_out
sudo docker run \
    -v /home/david/git/bwa-kit-rlc/iexec_in:/iexec_in \
    -v /home/david/git/bwa-kit-rlc/iexec_out:/iexec_out \
    -e IEXEC_IN=iexec_in \
    -e IEXEC_OUT=iexec_out \
    -e IEXEC_INPUT_FILE_NAME_1=TESTX_H7YRLADXX_S1_L001_R1_001.fastq \
    -e IEXEC_INPUT_FILE_NAME_2=TESTX_H7YRLADXX_S1_L001_R2_001.fastq \
    -e IEXEC_NB_INPUT_FILES=2 \
    -t bwa-mem-hs38-rlc \
    "-t 2"
# print result hash
cat iexec_out/result.txt
