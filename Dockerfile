FROM python:3.11.9-slim

ENV PYTHONPATH="${PYTHONPATH}:/usr/local/lib/python3.11/site-packages:/usr/lib/python3.11/site-packages:/app"
ENV FORCE_COLOR true
ENV DEBIAN_FRONTEND noninteractive
ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_CACHE_DIR="/cache/pip"

USER root
RUN apt-get update && \
  apt-get install -y --no-install-recommends build-essential gnupg2 libnss3 libxss1 libasound2 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdbus-1-3 libdrm2 libgbm1 libgtk-3-0 libnspr4 libxcomposite1 libxdamage1 libxfixes3 xvfb make gcc git curl wget unzip && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

# Download and install Docker binaries
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-20.10.9.tgz -o /tmp/docker.tgz && \
  tar --extract --file /tmp/docker.tgz --strip-components=1 --directory /usr/local/bin/ && \
  rm /tmp/docker.tgz

# Install containerd (optional, if not included in the Docker binaries)
RUN curl -fsSL https://github.com/containerd/containerd/releases/download/v1.4.11/containerd-1.4.11-linux-amd64.tar.gz -o /tmp/containerd.tgz && \
  tar --extract --file /tmp/containerd.tgz --strip-components=1 --directory /usr/local/bin/ && \
  rm /tmp/containerd.tgz

RUN curl https://storage.googleapis.com/chrome-for-testing-public/126.0.6478.61/linux64/chrome-linux64.zip --output chrome-linux64.zip
RUN unzip chrome-linux64.zip
RUN mv chrome-linux64 /chrome
RUN ln -s /chrome/chrome /usr/bin/google-chrome
RUN chown root:root /usr/bin/google-chrome
RUN chmod +x /usr/bin/google-chrome
RUN rm chrome-linux64.zip

RUN curl https://storage.googleapis.com/chrome-for-testing-public/126.0.6478.61/linux64/chromedriver-linux64.zip --output chromedriver-linux64.zip
RUN unzip chromedriver-linux64.zip
RUN mv chromedriver-linux64/chromedriver /usr/bin/chromedriver
RUN chown root:root /usr/bin/chromedriver
RUN chmod +x /usr/bin/chromedriver
RUN rm chromedriver-linux64.zip

# Set environment variables
ENV DISPLAY=:99

# Start Xvfb and keep the container running
CMD ["sh", "-c", "Xvfb :99 -screen 0 1024x768x16 & robot --outputdir /opt/robotframework/reports /opt/robotframework/tests"]
