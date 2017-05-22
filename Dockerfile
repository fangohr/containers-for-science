FROM ubuntu:16.04

ENV rubbish=temp
RUN apt-get update -y #
RUN apt-get install -y --fix-missing python3
RUN apt-get install -y --fix-missing python3-dev
RUN apt-get install -y --fix-missing git
RUN apt-get install -y python3-pip

ADD requirements.txt requirements.txt

RUN pip3 install -r requirements.txt
#CMD ["/bin/bash"]
