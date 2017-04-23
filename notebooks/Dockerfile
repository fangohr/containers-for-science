FROM ubuntu:16.04

RUN apt-get update 
RUN apt-get install -y cowsay

# cowsay installs into /usr/games. Make avaible in PATH:
RUN ln -s /usr/games/cowsay /usr/local/bin 

# create directory we use for input and output 
RUN mkdir /io

# change into that direcotry
WORKDIR /io