FROM ubuntu:22.04 AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential sudo && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential sudo && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS matias
RUN addgroup --gid 1000 matias
RUN adduser --gecos matias --uid 1000 --gid 1000 --disabled-password matias
RUN adduser matias sudo && echo "matias:matias" | chpasswd
USER matias
WORKDIR /home/matias

FROM matias
COPY . ./SetupMachine
WORKDIR /home/matias/SetupMachine
ARG TAGS
ENV TAGS=${TAGS}
CMD ["sh", "-c", "ansible-playbook local.yml --tags \"$TAGS\" -vvv --ask-become-pass --ask-vault-pass"]
#ansible-playbook local.yml --tags "dotfiles" -vvv --ask-become-pass --ask-vault-pass
