FROM php:8.3-cli

# PHP extensions the app needs for MySQL
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Allow Valid ID photo uploads
RUN { \
      echo "upload_max_filesize=10M"; \
      echo "post_max_size=12M"; \
      echo "display_errors=Off"; \
      echo "log_errors=On"; \
      echo "error_log=/dev/stderr"; \
    } > /usr/local/etc/php/conf.d/app.ini

WORKDIR /app
COPY . /app

# Folder for uploaded Valid IDs (it resets on every deploy; attach a Railway Volume to keep it)
RUN mkdir -p /app/assets/uploads/valid_ids && chmod -R 777 /app/assets/uploads

# Railway sets PORT. router.php opens Login.html at "/" and hides private folders.
CMD ["sh", "-c", "php -S 0.0.0.0:${PORT:-8080} -t /app /app/router.php"]
