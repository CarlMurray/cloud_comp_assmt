FROM httpd
WORKDIR /workspace
COPY . .
COPY ./*.html /usr/local/apache2/htdocs
COPY ./*.js /usr/local/apache2/htdocs
RUN echo ServerName localhost >> /usr/local/apache2/conf/httpd.conf
RUN apt update
RUN apt -y install curl
RUN bash getInstanceMetaData.sh