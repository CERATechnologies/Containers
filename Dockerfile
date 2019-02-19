FROM circleci/ruby:2.3.7-stretch-node-browsers
MAINTAINER developers <developers@oculo.com.au>

RUN sudo apt-get update -qq
RUN sudo apt-get install -y build-essential postgresql-client python-pip python-dev libssl-dev
RUN sudo pip install --upgrade pip
RUN sudo pip install awsebcli

# CHROMEDRIVER
USER root
WORKDIR /

RUN which chromedriver
RUN uname -a
ENV CHROMEDRIVER_VERSION 73.0.3683.20
ENV CHROMEDRIVER_DIR /tmp/chromedriver
RUN mkdir $CHROMEDRIVER_DIR

RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
  echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update && \
  apt-get install --no-install-recommends -y \
    google-chrome-stable && \
    apt-get clean

RUN cd $CHROMEDRIVER_DIR
RUN curl https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip --output chromedriver_linux64.zip && \
  unzip -u chromedriver_linux64.zip && \
  mv chromedriver /usr/local/bin/

RUN chown circleci:circleci /usr/local/bin/chromedriver
RUN chmod +x /usr/local/bin/chromedriver

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

RUN yarn global add phantomjs-prebuilt@2.1.16

# have had issues installing ghostscript, now that they are resolved(?) we
# should be able to add these to the previous apt-get install
RUN apt-get install -y ghostscript imagemagick
