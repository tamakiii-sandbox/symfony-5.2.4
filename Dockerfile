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
      php80-php-common \
      php80-php-cli \
      php80-php-json \
      php80-php-fpm \
      php80-php-opcache \
      php80-php-process \
      php80-php-mbstring \
      php80-php-xml \
      php80-php-mysqlnd

RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

RUN php80 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php80 -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php80 composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php80 -r "unlink('composer-setup.php');"

WORKDIR /local/symfony-5.2.4

