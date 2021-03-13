FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y --allow-downgrades \
  curl \
  docker.io \
  libpython3-dev \
  python3-pip \
  && apt-get clean && rm -rf /var/lib/apt/lists/

ADD toy-cdk /tmp/toy-cdk

WORKDIR /tmp/toy-cdk/

RUN pip3 install -r requirements.txt


ENV NODE_VERSION=14.15.4
ENV CDK_VERSION=1.88.0
ENV CRC32_STREAM_VERSION=4.0.2
ENV ARCHIVER_VERSION=5.2.0

RUN ./install.sh

ENV PATH=/tmp/toy-cdk/node_modules/.bin:${PATH}
ENV PATH=/tmp/toy-cdk/.node-versions/node-v${NODE_VERSION}-linux-x64/bin:${PATH}

CMD ["/tmp/toy-cdk/run.sh"]
