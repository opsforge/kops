# Dockerfile of opsforge.io kops image for automated builds - Copyright (C) 2018 George Svachulay - Apache 2.0 License

FROM ubuntu:18.04

MAINTAINER opsforge.io
LABEL name="kops"
LABEL version="1.0.0"

RUN apt update && \
    apt install -y \
      git \
      curl \
      dnsutils \
      jq \
      python-pip \
      netcat \
      inetutils-ping && \
    pip install awscli && \
    mkdir -p .aws && touch .aws/config && touch .aws/credentials && \
    apt clean

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# Install kops
RUN curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 && \
    chmod +x kops-linux-amd64 && \
    mv kops-linux-amd64 /usr/local/bin/kops

CMD /bin/bash