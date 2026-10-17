FROM php:8.3-apache

# Database drivers used by php/db.php (PDO MySQL) plus mysqli.
RUN docker-php-ext-install pdo_mysql mysqli

COPY . /var/www/html/

# Entrypoint rewrites Apache's listen port to Railway's $PORT at startup.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN sed -i 's/\r$//' /usr/local/bin/docker-entrypoint.sh \
    && chmod +x /usr/local/bin/docker-entrypoint.sh \
    && chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["docker-entrypoint.sh"]
