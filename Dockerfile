FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y --fix-missing python3
RUN apt-get install -y --fix-missing python3-dev
#RUN apt-get install -y --fix-missing python3-pip
#RUN pip install -r requirements.txt

#CMD ["/bin/bash"]
