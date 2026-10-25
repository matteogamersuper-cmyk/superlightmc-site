# Usa l'immagine ufficiale di PHP con FPM (già include PHP-FPM attivo)
FROM php:8.2-fpm

# Installa Nginx e ELIMINA la configurazione di default
RUN apt-get update && apt-get install -y nginx && \
    rm -f /etc/nginx/conf.d/default.conf && \
    rm -rf /var/lib/apt/lists/*

# Copia la TUA configurazione di Nginx in /etc/nginx/sites-available/
COPY nginx.conf /etc/nginx/sites-available/superlightmc

# Crea un link simbolico a /etc/nginx/sites-enabled/
RUN ln -sf /etc/nginx/sites-available/superlightmc /etc/nginx/sites-enabled/

# Rimuovi il link a default (se esiste)
RUN rm -f /etc/nginx/sites-enabled/default

# Copia i file del sito nella directory di Nginx
COPY . /var/www/html

# Imposta la directory di lavoro
WORKDIR /var/www/html

# Crea uno script per avviare SOLO Nginx (PHP-FPM è già attivo nell'immagine)
RUN echo '#!/bin/bash\n\
nginx -g "daemon off;"' > /start.sh && \
chmod +x /start.sh

# Avvia lo script
CMD ["/start.sh"]
