server {
    listen 80;
    server_name sso.itproblog.ru;
    return 301 https://sso.itproblog.ru$request_uri;
}

server {
    listen 443 ssl;
    server_name  sso.itproblog.ru;
    include conf.d/nginx_ssl.conf;
    access_log /var/log/nginx/sso.itproblog.ru.access.log;
    error_log  /var/log/nginx/sso.itproblog.ru.error.log info;
   
    proxy_ssl_session_reuse off;
    proxy_buffering off;
    ssl_session_cache off;

    location / {
        proxy_ssl_server_name on;
        proxy_ssl_name sso.itproblog.ru;
        proxy_pass https://10.10.10.21;
        proxy_set_header Host $host;
        proxy_redirect off; 
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
    }
}