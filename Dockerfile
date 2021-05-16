FROM ubuntu:20.04

# prepare system
RUN apt update && apt upgrade -y
#RUN ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    wget build-essential zlib1g-dev samblaster samtools && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

# get bwa
RUN wget https://github.com/lh3/bwa/releases/download/v0.7.17/bwa-0.7.17.tar.bz2 && \
    bunzip2 bwa-0.7.17.tar.bz2 && \
    tar -xf bwa-0.7.17.tar

RUN cd bwa-0.7.17 && make && cd ..
# download and index reference data
RUN bwa-0.7.17/bwakit/run-gen-ref hs38
RUN bwa-0.7.17/bwa index hs38.fa

# download script from repo
RUN wget https://raw.githubusercontent.com/david4096/bwa-kit-rlc/0.1a10/bwamem.sh
RUN chmod a+x bwamem.sh
RUN pwd
# use script as entrypoint
ENTRYPOINT ["/bin/bash", "bwamem.sh"]
