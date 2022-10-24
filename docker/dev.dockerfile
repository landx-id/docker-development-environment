FROM --platform=linux/x86_64 ubuntu:jammy

RUN apt update -y && \
    apt install -y wget jq software-properties-common \
    git curl apt-transport-https build-essential libpq-dev 

RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
    
RUN apt update -y && \ 
    apt install -y terraform

WORKDIR /opt/build

# SSH
RUN apt install -y openssh-server \
	&& mkdir /var/run/sshd
COPY sshd_config /etc/ssh/sshd_config
ENTRYPOINT ["/opt/dev-env/init-env"]

# NVM
RUN git clone https://github.com/creationix/nvm.git /opt/nvm \
	&& cd /opt/nvm \
	&& git checkout v0.39.2

# Customize environment
ARG USERNAME=default
ARG USERID=1000
RUN useradd -m -u ${USERID} --shell /bin/bash ${USERNAME}
