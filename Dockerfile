FROM ubuntu:18.04

ENV AWS_CDK_VERSION=1.86.0

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y --allow-downgrades \
  curl \
  docker.io \
  libpython3-dev \
  python3-pip \
  nodejs \
  npm \
  && apt-get clean && rm -rf /var/lib/apt/lists/

RUN npm install -g aws-cdk@${AWS_CDK_VERSION}
RUN npm install -g n
RUN n 12.12.0

ADD toy-cdk /opt/toy-cdk

RUN pip3 install -r /opt/toy-cdk/requirements.txt

WORKDIR /opt/toy-cdk/

CMD ["cdk", "deploy"]
