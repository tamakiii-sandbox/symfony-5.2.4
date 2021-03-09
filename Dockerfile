FROM amazonlinux:2.0.20210219.0 AS production-pseudo

RUN yum update && \
    yum install -y \
      yum-utils \
      which \
      less \
      wget \
      curl \
      git

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum-config-manager --enable remi-php80

RUN yum install -y \
      php80 \
      php80-common \
      php80-cli \
      php80-json \
      php80-fpm \
      php80-opcache \
      php80-process \
      php80-mbstring \
      php80-xml \
      php80-php-mysqlnd

RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

WORKDIR /local/symfony-5.2.4

