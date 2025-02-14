FROM ubuntu:22.04
WORKDIR /workspace
COPY . /workspace
RUN apt update && apt -y install
RUN apt -y install curl
RUN apt -y install unzip
RUN sh ./install_aws_cli.sh && sh ./install_ansible.sh
RUN pipx ensurepath
RUN export PATH="/root/.local/bin:$PATH"
CMD [ "/bin/bash" ]