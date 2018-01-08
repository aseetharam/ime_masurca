FROM ubuntu:xenial

LABEL maintainer="frank.foerster@ime.fraunhofer.de"
LABEL description="Dockerfile providing the MaSuRCA hybrid assembler"

WORKDIR /opt/

RUN apt update && apt install --yes \
        build-essential \
        curl \
        wget \
        zlib1g-dev \
        libbz2-dev && \
    wget ftp://ftp.genome.umd.edu/pub/MaSuRCA/latest/MaSuRCA-3.2.3.tar.gz && \
    tar xzf MaSuRCA-3.2.3.tar.gz && \
    rm MaSuRCA-3.2.3.tar.gz && \
    cd MaSuRCA-3.2.3 && \
    BOOST_ROOT=install ./install.sh && \
    apt remove --yes \
        build-essential \
        curl \
        wget

VOLUME /data

WORKDIR /data

ENV MASURCAPATH=/opt/MaSuRCA-3.2.3
ENV PATH=$MASURCAPATH/bin:$PATH
ENV SR_CONFIG_EXAMPLE=$MASURCAPATH/sr_config_example.txt

CMD masurca
