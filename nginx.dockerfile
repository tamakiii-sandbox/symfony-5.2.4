FROM amazonlinux:2.0.20210219.0 AS production-pseudo

RUN yum update && \
    yum install -y \
      yum-utils \
      which \
      less \
      wget \
      curl \
      git

WORKDIR /local/symfony-5.2.4
