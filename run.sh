#!/bin/bash
cwd=$(pwd)
domains="";

#Check for the www folder from nginx
if test -z "$NGINX_VAR_WWW" 
then
  echo "NGINX_VAR_WWW não está definido"
  exit -1
fi

#Check for the certbot mail
if test -z "$CERTBOT_MAIL" 
then
  echo "CERTBOT_MAIL não está definido"
  exit -1
fi

#Checking if domains file existis
if test -z "$CERTBOT_DOMAINS"; then
  echo "Variável CERTBOT_DOMAINS não encontrada"
  exit -1
fi

#Validating all domains
while IFS="" read -r domain
do  
    docker run --rm \
      -v $NGINX_VAR_WWW:/data/letsencrypt \
      -v $cwd/etc/letsencrypt:/etc/letsencrypt \
      -v $cwd/var/lib/letsencrypt:/var/lib/letsencrypt \
      -v $cwd/var/log/letsencrypt:/var/log/letsencrypt \
      certbot/certbot \
      certonly --webroot \
      --email $CERTBOT_MAIL --agree-tos --no-eff-email \
      --webroot-path=/data/letsencrypt \
      $domain
done < $CERTBOT_DOMAINS
