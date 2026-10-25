# Usa l'immagine ufficiale di PHP con Nginx integrato
FROM php:8.2-fpm

# Installa Nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Copia la configurazione di Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia i file del sito nella directory di Nginx
COPY . /var/www/html

# Imposta la directory di lavoro
WORKDIR /var/www/html

# Avvia Nginx e PHP-FPM
CMD service nginx start && php-fpm
