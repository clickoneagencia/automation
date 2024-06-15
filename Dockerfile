FROM python:3.11.9-slim

ENV FORCE_COLOR true
ENV DEBIAN_FRONTEND noninteractive

USER root
RUN apt-get update && \
  apt-get install -y --no-install-recommends build-essential libssl-dev libffi-dev libncurses5-dev zlib1g zlib1g-dev libreadline-dev libbz2-dev libsqlite3-dev make gcc git curl wget unzip chromium && \
  apt-get clean
RUN ln -s /usr/lib/chromium-browser/chromium-browser /usr/bin/google-chrome

RUN wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN mv chromedriver /usr/bin/chromedriver
RUN chown root:root /usr/bin/chromedriver
RUN chmod +x /usr/bin/chromedriver

RUN rm -rf /var/lib/apt/lists/*
