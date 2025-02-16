FROM httpd
WORKDIR /workspace
COPY . .
RUN apt update
RUN apt -y install curl
RUN bash getInstanceMetaData.sh
RUN mv ~/metadata.html /usr/local/apache2/htdocs
RUN mv /home/ubuntu/cloud_comp_assmt/ec2_files /usr/local/apache2/htdocs
CMD ["/bin/bash"]