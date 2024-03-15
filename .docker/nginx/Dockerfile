FROM nginx:1.21-alpine

COPY .docker/nginx/nginx.conf  /etc/nginx/

COPY .docker/nginx/templates /etc/nginx/templates/

COPY . /var/www/symfony

RUN echo "upstream php-upstream { server localhost:9000; }" > /etc/nginx/conf.d/upstream.conf

EXPOSE 80

EXPOSE 443
