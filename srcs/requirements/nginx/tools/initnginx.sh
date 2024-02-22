#!/bin/bash

cat > nginx.conf << EOF
server {
    listen 443 ssl;
	listen [::]:443 ssl;

    server_name ${DOMAIN_NAME};
	
    ssl_certificate ${CERTS_CRT};
    ssl_certificate_key ${CERTS_KEY};
    ssl_protocols TLSv1.2 TLSv1.3;

	root /var/www/html;
	index index.php;
	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass wordpress:9000;
	}
}
EOF

mv nginx.conf /etc/nginx/conf.d/nginx.conf

exec "$@"