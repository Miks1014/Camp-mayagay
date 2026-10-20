FROM php:8.3-apache

# Database drivers used by php/db.php (PDO MySQL) plus mysqli.
RUN docker-php-ext-install pdo_mysql mysqli

# Apache refuses to start with more than one MPM loaded. Remove every MPM link
# from mods-enabled directly, link only mpm_prefork, and fail the build if the
# result is not exactly one MPM.
RUN rm -f /etc/apache2/mods-enabled/mpm_*.load /etc/apache2/mods-enabled/mpm_*.conf \
    && ln -s ../mods-available/mpm_prefork.load /etc/apache2/mods-enabled/mpm_prefork.load \
    && ln -s ../mods-available/mpm_prefork.conf /etc/apache2/mods-enabled/mpm_prefork.conf \
    && apache2ctl -M 2>&1 | grep -c mpm_ | grep -qx 1

COPY . /var/www/html/

# Entrypoint rewrites Apache's listen port to Railway's $PORT at startup.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN sed -i 's/\r$//' /usr/local/bin/docker-entrypoint.sh \
    && chmod +x /usr/local/bin/docker-entrypoint.sh \
    && chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["docker-entrypoint.sh"]
