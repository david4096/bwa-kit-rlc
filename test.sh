#!/bin/bash
# prepare the input data
mkdir -p iexec_in
cd iexec_in
# download example sequence from 1kgenomes
wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG00096/sequence_read/SRR062634_1.filt.fastq.gz
wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG00096/sequence_read/SRR062634_2.filt.fastq.gz
cd ../
# prepare output location
mkdir -p iexec_out
docker run \
    -v /tmp/iexec_in:/iexec_in \
    -v /tmp/iexec_out:/iexec_out \
    -e IEXEC_IN=iexec_in \
    -e IEXEC_OUT=iexec_out \
    -e IEXEC_INPUT_FILE_NAME_1=SRR062634_1.filt.fastq.gz \
    -e IEXEC_INPUT_FILE_NAME_2=SRR062634_2.filt.fastq.gz \
    -e IEXEC_NB_INPUT_FILES=2 \
    bwa-mem-hs38-rlc \
    "-t 2 -s"
# print result hash
cat iexec_out/result.txt
