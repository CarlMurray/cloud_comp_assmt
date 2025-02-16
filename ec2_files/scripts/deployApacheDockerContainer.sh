#!/bin/bash
docker run --name apache-container -d -p 80:80 -p 443:443 -v /home/ubuntu/cloud_comp_assmt/ec2_files:/usr/local/apache2/htdocs httpd
