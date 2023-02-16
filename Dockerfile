FROM debian:latest
COPY challenge.sh /challenge.sh
ARG terraformVersion=1.3.9
ARG kubectlVersion=1.21.0
#install aws cli, terraform, and kubectl
#RUN apt-get update && apt-get install git -y 
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    python3 \
    python3-pip \
    git \
    && pip3 install awscli \
    && curl -O https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_amd64.zip \
    && unzip terraform_${terraformVersion}_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v${kubectlVersion}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && chmod 755 /challenge.sh

# entry point for the container
#CMD ["/challenge.sh"]

#ENTRYPOINT ["/challenge.sh"]