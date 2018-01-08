FROM ubuntu:xenial

LABEL maintainer="frank.foerster@ime.fraunhofer.de"
LABEL description="Dockerfile providing the MaSuRCA hybrid assembler"

RUN apt update && apt install --yes \
    build-essential \
    curl \
    wget \
    zlib1g-dev \
    libbz2-dev

WORKDIR /opt/

RUN wget ftp://ftp.genome.umd.edu/pub/MaSuRCA/latest/MaSuRCA-3.2.3.tar.gz && tar xzf MaSuRCA-3.2.3.tar.gz && rm MaSuRCA-3.2.3.tar.gz

WORKDIR MaSuRCA-3.2.3

RUN BOOST_ROOT=install ./install.sh

VOLUME /data

WORKDIR /data

ENV MASURCAPATH=/opt/MaSuRCA-3.2.3
ENV PATH=$MASURCAPATH/bin:$PATH
ENV SR_CONFIG_EXAMPLE=$MASURCAPATH/sr_config_example.txt
