FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y python3 python3-dev git pandoc

# This is a big package to install. The missing executable was 'xelatex':
RUN apt-get install -y pandoc texlive-xetex

# Also need pip
RUN apt-get install -y python3-pip
RUN mkdir -p /opt/install

# install packages from requirements.txt file
WORKDIR /opt/install

# Add requirements.txt from outside container into container
ADD requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Create directory to which we will mount the host file system
RUN mkdir -p /io
WORKDIR /io

# Offer bash by default
CMD ["/bin/bash"]
