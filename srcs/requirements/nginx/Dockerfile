FROM  debian:buster

ARG DOMAIN_NAME
ARG CERTS_KEY
ARG CERTS_CRT

RUN apt update && apt install nginx openssl bash -y \
	&& mkdir /etc/nginx/ssl \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048\
    -subj "/C=CA/ST=QC/O=42SP/CN=aminoru-.42.fr" \
    -keyout ${CERTS_KEY} \
    -out ${CERTS_CRT}

COPY ./tools/initnginx.sh initnginx.sh
RUN chmod +x initnginx.sh && bash initnginx.sh && rm -f initnginx.sh

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]