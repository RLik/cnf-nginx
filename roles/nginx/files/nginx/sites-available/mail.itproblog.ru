server {
        listen 80;
        server_name mail.itproblog.ru autodiscover.itproblog.ru;
        return 301 https://$host$request_uri;
}

server {
        listen 443 ssl;
        server_name mail.itproblog.ru;
        set $exchange2019 https://10.10.10.24:443;

        # Redirect from "/" to "/owa" by default
        rewrite ^/$ https://mail.itproblog.ru/owa permanent;

        # Enable SSL
        include conf.d/nginx_ssl.conf;
        ssl_session_timeout     5m;

        # Set global proxy settings
        proxy_pass_request_headers on;
        proxy_read_timeout      360;

        proxy_pass_header       Date;
        proxy_pass_header       Server;

        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;

        location ~* ^/owa      { proxy_pass $exchange2019; }
        location ~* ^/Microsoft-Server-ActiveSync { proxy_pass $exchange2019; }
        location ~* ^/ecp { proxy_pass $exchange2019; }
        location ~* ^/Rpc { proxy_pass $exchange2019; }
        error_log /var/log/nginx/Exchange-error.log;
        access_log /var/log/nginx/Exchange-access.log;
}

server {
        listen 443 ssl;
        server_name autodiscover.itproblog.ru;
        set $exchange2019 https://10.10.10.24:443;

        # Enable SSL
        include conf.d/nginx_ssl.conf;
        ssl_session_timeout     5m;

        # Set global proxy settings
        proxy_pass_request_headers on;
        proxy_read_timeout      360;

        proxy_pass_header       Date;
        proxy_pass_header       Server;

        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;

        location ~* ^/Autodiscover { proxy_pass $exchange2019; }

        error_log /var/log/nginx/Exchange-error.log;
        access_log /var/log/nginx/Exchange-access.log;
}