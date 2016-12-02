FROM debian:latest
MAINTAINER Philip Jackson <p-jackson@live.com>

RUN apt-get update -qq && \
    apt-get install -y curl

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs git yarn

# Don't do the usual thing of clearing apt's cache
# This is a dev box so size is less important and we may want to quickly
# install something that's missing
# rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
RUN ~/.bash_it/install.sh --silent
RUN echo "export BASH_IT_THEME='envy'" >> ~/.bashrc

RUN git config --global user.useconfigonly true

EXPOSE 1-10000

WORKDIR /root
