FROM circleci/ruby:2.4.4-node-browsers
MAINTAINER jdubs <jgw@oculo.com.au>

RUN sudo apt-get update -qq \
  && sudo apt-get install -y build-essential postgresql-client python-pip python-dev imagemagick \
  && sudo pip install --upgrade pip \
  && sudo pip install awsebcli
