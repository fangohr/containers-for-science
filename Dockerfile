FROM docker:dind
## FROM ubuntu:18.04
## ENV DEBIAN_FRONTEND=noninteractive
## RUN apt-get update -y && apt-get install -y python3 python3-dev git pandoc pandoc texlive-xetex python3-pip && rm -rf /var/lib/apt/lists/*
##
## # instructions to install docker-ce from
## # https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04
## RUN apt-get update
## RUN apt-get install -y curl
## RUN apt install -y apt-transport-https ca-certificates curl software-properties-common
## #RUN apt-transport-https ca-certificates curl software-properties-common
## # Then add the GPG key for the official Docker repository to your system:
## RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
## # Add the Docker repository to APT sources:
## RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
## # Next, update the package database with the Docker packages from the newly added repo:
## RUN apt-get update
## # Make sure you are about to install from the Docker repo instead of the default Ubuntu repo:
## # RUN apt-cache policy docker-ce
## RUN apt-get install -y docker-ce
##
##

# install python3 in alpine
# from https://github.com/frol/docker-alpine-python3/blob/master/Dockerfile

RUN apk add --no-cache python3 python3-dev && \
   python3 -m ensurepip && \
   rm -r /usr/lib/python*/ensurepip && \
   pip3 install --upgrade pip setuptools && \
   if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
   if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi
   #&& \
   #rm -r /root/.cache


# Need gcc for python requirements
# from https://github.com/frol/docker-alpine-gcc/blob/master/Dockerfile
RUN apk add --no-cache gcc musl-dev g++ alpine-sdk


RUN mkdir -p /opt/install

# install packages from requirements.txt file
WORKDIR /opt/install

# Add requirements.txt from outside container into container
ADD requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

# Create directory to which we will mount the host file system
RUN mkdir -p /io
WORKDIR /io


RUN apk add -U make


# latex in Alpine (https://github.com/mattmahn/docker-latex/blob/master/Dockerfile)
# dependencies for texlive
RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/edge/main \
poppler harfbuzz-icu

# zziplib (found in edge/community repository) is a dependency to texlive-luatex
RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/edge/community \
zziplib

RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/edge/testing \
texlive-full

RUN ln -s /usr/bin/mktexlsr /usr/bin/mktexlsr.pl


# Offer bash by default
CMD ["/usr/local/bin/dockerd-entrypoint.sh"]
# CMD ["/bin/bash"]
