# This package gets nginx from debian stretch distribution
FROM nginx

MAINTAINER Himanshu Verma <himanshu@attabot.io>

# Remove default nginx configs.
RUN rm -f /etc/nginx/conf.d/*

ENV DEBIAN_FRONTEND noninteractive

# Install necessary packages 

#RUN sh -c "echo 'deb http://packages.dotdeb.org jessie all' >> #/etc/apt/sources.list"
#RUN sh -c "echo 'deb-src http://packages.dotdeb.org jessie all' >> #/etc/apt/sources.list"

#RUN apt-get update -y \
#    && apt-get install --no-install-recommends --no-install-suggests -y gnupg1 apt-transport-https ca-certificates curl cron git supervisor php7.0-fpm php7.0-mcrypt php7.0-intl #php7.0-mysql php7.0-curl php7.0-xmlrpc php7.0-imap php7.0-cli php7.0-zip php-pear php7.0-xdebug \
#    && rm -rf /var/lib/apt/lists/*

# Install PHP 7 Repo
#RUN apt-get update && apt-get install -my wget gnupg
#RUN sh -c "echo 'deb http://packages.dotdeb.org stretch all' >> /etc/apt/sources.list"
#RUN sh -c "echo 'deb-src http://packages.dotdeb.org stretch all' >> /etc/apt/sources.list"
#RUN wget https://www.dotdeb.org/dotdeb.gpg -O - | apt-key add -
#RUN wget https://nginx.org/keys/nginx_signing.key -O - | apt-key add -

RUN apt-get update -y \
    && apt-get install --no-install-recommends --no-install-suggests -y gnupg1 apt-transport-https ca-certificates curl cron git php7.0-fpm php7.0-cli php7.0-dev php7.0-sqlite3 php7.0-gd php-apcu php7.0-curl php7.0-mcrypt php7.0-imap php7.0-intl php7.0-mysql php7.0-readline php-xdebug php-common php7.0-mbstring php7.0-xml php7.0-zip php-pear php7.0-xdebug \
    && rm -rf /var/lib/apt/lists/*

#RUN phpenmod mcrypt

# Ensure that PHP7 FPM is run as root.
RUN service php7.0-fpm start


RUN curl -sS https://getcomposer.org/installer | php -- --disable-tls \
    && mv composer.phar /usr/local/bin/composer

RUN sed -i 's/user  nginx/user  www-data/g' /etc/nginx/nginx.conf

# Force PHP to log to nginx
#RUN echo "catch_workers_output = yes" >> /etc/php/7.0/fpm/php-fpm.conf

#RUN ln -sf /dev/stdout /var/log/nginx/access.log \
#        && ln -sf /dev/stderr /var/log/nginx/error.log

# Enable php by default
#RUN rm -rf /etc/nginx/conf.d/default.conf
#ADD default.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/

#RUN rm -rf *

# Clone the project from git
RUN rm -rf *
RUN git clone https://github.com/ladybirdweb/faveo-helpdesk.git .
RUN composer install


#RUN chgrp -R www-data . storage bootstrap/cache
#RUN chmod -R ug+rwx . storage bootstrap/cache

# Add to crontab file
#RUN touch /etc/cron.d/faveo-cron
#RUN echo '* * * * * php /usr/share/nginx/artisan schedule:run > /dev/null 2>&1' >>/etc/cron.d/faveo-cron
#RUN chmod 0644 /etc/cron.d/faveo-cron
#RUN crontab /etc/cron.d/faveo-cron
#RUN sed -i "s/max_execution_time = .*/max_execution_time = 120/" /etc/php/7.0/fpm/php.ini \
#    && sed -i "s/php_admin_value\[max_execution_time\] = .*/php_admin_value[max_execution_time] = 300/" /etc/php/7.0/fpm/pool.d/www.conf

VOLUME /usr/share/nginx/

#CMD cron \
#    && service php7.0-fpm start \
#    && nginx -g "daemon off;"