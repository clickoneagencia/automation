FROM ubuntu:24.04

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

# Pyenv
RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv
ENV PYENV_ROOT $ROOT_DIR/.pyenv
ENV PATH "${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"

ENV PYTHON_VERSION=3.11.9
RUN pyenv install ${PYTHON_VERSION}
RUN pyenv global ${PYTHON_VERSION}

RUN python3.11 -m pip install --upgrade pip
RUN python3.11 -m pip install virtualenv
RUN python3.11 -m virtualenv -p python3.11 env
ENV PYTHONPATH="${PYTHONPATH}:/usr/local/lib/python3.11/site-packages:/usr/lib/python3.11/site-packages:${ROOT_DIR}/env/lib/python3.11/site-packages:${ROOT_DIR}"
ENV PATH "${PYENV_ROOT}/versions/${PYTHON_VERSION}/lib/python3.11/site-packages:${ROOT_DIR}/env/bin:${PATH}"

# NVM
RUN git clone https://github.com/nvm-sh/nvm.git .nvm
ENV NVM_DIR "$ROOT_DIR/.nvm"
RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
RUN [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

ENV NODE_TARGET_VERSION 20.14.0
RUN . $NVM_DIR/nvm.sh && \
  nvm install ${NODE_TARGET_VERSION} && \
  nvm alias default ${NODE_TARGET_VERSION} && \
  nvm use default

ENV PATH $NVM_DIR/versions/node/v${NODE_TARGET_VERSION}/bin:$PATH

RUN rm -rf /var/lib/apt/lists/*
