# Usa l'immagine ufficiale di PHP con FPM
FROM php:8.2-fpm

# Installa Nginx e rimuovi la configurazione di default
RUN apt-get update && apt-get install -y nginx && \
    rm -rf /etc/nginx/conf.d/default.conf && \
    rm -rf /var/lib/apt/lists/*

# Copia la TUA configurazione di Nginx (solo quella che vuoi usare)
COPY nginx.conf /etc/nginx/conf.d/

# Copia i file del sito nella directory di Nginx
COPY . /var/www/html

# Imposta la directory di lavoro
WORKDIR /var/www/html

# Crea uno script per avviare Nginx (senza demonizzare)
RUN echo '#!/bin/bash\n\
nginx -g "daemon off;"' > /start.sh && \
chmod +x /start.sh

# Avvia lo script
CMD ["/start.sh"]
