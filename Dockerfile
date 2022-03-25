FROM python:3.10-buster
ENV DEBIAN_FRONTEND=noninteractive 
LABEL maintainer="gustavo.mkuno@outlook.com"

ENV TERRAFORM_VERSION="1.1.7"

COPY requirements.txt .
RUN pip install pip --upgrade && \
    pip install --no-cache-dir -r requirements.txt

RUN apt update -y && \
    apt install -y \
    sshpass libxml2-utils openssh-client curl

#COPY roles-requirements.yml .
#RUN ansible-galaxy install -r roles-requirements.yml

RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Azure CLI
ADD https://raw.githubusercontent.com/ansible-collections/azure/dev/plugins/inventory/azure_rm.py /root/.ansible/plugins/azure_rm.py
RUN chmod +x /root/.ansible/plugins/azure_rm.py
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash 

WORKDIR /work

ADD auth_azcli.sh .

ENTRYPOINT [ "/bin/bash", "-c"]