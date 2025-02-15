FROM ubuntu:22.04
WORKDIR /workspace
COPY . /workspace
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt -y install
RUN apt -y install curl
RUN apt -y install unzip
RUN apt -y install pip
RUN sh ./install_aws_cli.sh && sh ./install_ansible.sh
RUN pipx ensurepath
RUN echo "export PATH='/root/.local/bin:$PATH'" >> ~/.bashrc
RUN exec bash
CMD [ "/bin/bash" ]