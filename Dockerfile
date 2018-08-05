# This package gets nginx from debian stretch distribution
FROM nginx

MAINTAINER Himanshu Verma <himanshu@attabot.io>

# Remove default nginx configs.
RUN rm -f /etc/nginx/conf.d/*

ENV DEBIAN_FRONTEND noninteractive

RUN apt -y update && apt -y upgrade
RUN apt install -y apt-transport-https lsb-release ca-certificates wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN apt update




# Install necessary packages 
#RUN apt-get update -y \
#    && apt-get install --no-install-recommends --no-install-suggests -y gnupg1 #apt-transport-https ca-certificates curl cron git php7.1-fpm php7.1-cli php7.1-dev #php7.1-sqlite3 php7.1-gd php-apcu php7.1-curl php7.1-mcrypt php7.1-imap php7.1-intl #php7.1-mysql php7.1-readline php-xdebug php-common php7.1-mbstring php7.1-xml #php7.1-zip php-pear php7.1-xdebug \
#    && rm -rf /var/lib/apt/lists/*

#RUN phpenmod mcrypt

# Ensure that PHP7 FPM is run as root.
#RUN service php7.1-fpm start


#RUN curl -sS https://getcomposer.org/installer | php -- --disable-tls \
#    && mv composer.phar /usr/local/bin/composer

#RUN sed -i 's/user  nginx/user  www-data/g' /etc/nginx/nginx.conf


# Force PHP to log to nginx
#RUN echo "catch_workers_output = yes" >> /etc/php/7.1/fpm/php-fpm.conf

#RUN ln -sf /dev/stdout /var/log/nginx/access.log \
#        && ln -sf /dev/stderr /var/log/nginx/error.log

# Enable php by default
#RUN rm -rf /etc/nginx/conf.d/default.conf
#ADD default.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/

#RUN rm -rf *

# Clone the project from git
#RUN rm -rf *
# This *WILL* work, but we need PHP 7.1 for it
#RUN git clone --depth 1 https://github.com/ladybirdweb/faveo-helpdesk.git -b #clean-dev .
#RUN composer install


#RUN chgrp -R www-data . storage bootstrap/cache
#RUN chmod -R ug+rwx . storage bootstrap/cache

# Add to crontab file
#RUN touch /etc/cron.d/faveo-cron
#RUN echo '* * * * * php /usr/share/nginx/artisan schedule:run > /dev/null 2>&1' >>/etc/cron.d/faveo-cron
#RUN chmod 0644 /etc/cron.d/faveo-cron
#RUN crontab /etc/cron.d/faveo-cron
#RUN sed -i "s/max_execution_time = .*/max_execution_time = 120/" /etc/php/7.1/fpm/php.ini \
#    && sed -i "s/php_admin_value\[max_execution_time\] = .*/php_admin_value[max_execution_time] = 300/" /etc/php/7.1/fpm/pool.d/www.conf

VOLUME /usr/share/nginx/

#CMD cron \
#    && service php7.1-fpm start \
#    && nginx -g "daemon off;"