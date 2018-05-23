FROM circleci/ruby:2.3.7-stretch-node-browsers
MAINTAINER jdubs <jgw@oculo.com.au>

RUN sudo apt-get update -qq
RUN sudo apt-get install -y build-essential postgresql-client python-pip python-dev
RUN sudo pip install --upgrade pip
RUN sudo pip install awsebcli
RUN sudo apt-get install -y ghostscript imagemagick
