FROM php:8.3-cli

# Database drivers used by php/db.php (PDO MySQL) plus mysqli.
RUN docker-php-ext-install pdo_mysql mysqli

WORKDIR /var/www/html
COPY . /var/www/html/

EXPOSE 80

# PHP's built-in server serves static files and PHP scripts from the document root.
CMD ["sh", "-c", "exec php -S 0.0.0.0:${PORT:-80} -t /var/www/html"]
