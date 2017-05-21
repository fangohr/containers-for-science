FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y --fix-missing python3
RUN apt-get install -y --fix-missing python3-dev
RUN apt-get install -y --fix-missing git

RUN git clone https://github.com/takluyver/bookbook.git
RUN cd bookbook && flit install

#RUN apt-get install -y --fix-missing python3-pip
#RUN pip install -r requirements.txt

#CMD ["/bin/bash"]
