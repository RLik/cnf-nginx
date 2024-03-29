server {
  listen 80;
  server_name oos.itproblog.ru;

  # Redirect all traffic to SSL
  rewrite ^ https://$host$request_uri? permanent;
}

server {
  listen 443 ssl;

  # enables SSLv3/TLSv1, but not SSLv2 which is weak and should no longer be used.
  # ssl_protocols SSLv3 TLSv1;
  
  # disables all weak ciphers
  ssl_ciphers ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM;

  server_name oos.itproblog.ru;

  ## Access and error logs.
  access_log /var/log/nginx/oos.itproblog.ru.access.log;
  error_log  /var/log/nginx/oos.itproblog.ru.error.log info;

  ## Keep alive timeout set to a greater value for SSL/TLS.
  keepalive_timeout 75 75;

  ## See the keepalive_timeout directive in nginx.conf.
  ## Server certificate and key.
  include conf.d/nginx_ssl.conf;
  ssl_session_timeout  5m;

  ## Strict Transport Security header for enhanced security. See
  ## http://www.chromium.org/sts. I've set it to 2 hours; set it to
  ## whichever age you want.
  add_header Strict-Transport-Security "max-age=7200";

  location / {
    proxy_pass https://10.10.10.59;
  }
}