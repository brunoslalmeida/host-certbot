cwd=$(pwd)

docker run --rm \
  -it \
  --name certbot \
  -v $NGINX_VAR_WWW:/data/letsencrypt \
  -v $cwd/etc/letsencrypt:/etc/letsencrypt \
  -v $cwd/var/lib/letsencrypt:/var/lib/letsencrypt \
  -v $cwd/var/log/letsencrypt:/var/log/letsencrypt \
  certbot/certbot renew \
  --webroot \
  -w /data/letsencrypt \
  --quiet && \
  docker kill --signal=HUP nginx
