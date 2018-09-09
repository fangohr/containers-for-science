FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install -y python3 python3-dev git pandoc pandoc texlive-xetex python3-pip && rm -rf /var/lib/apt/lists/*
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
