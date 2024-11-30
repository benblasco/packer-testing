# Fedora Toolbox container to test Hashicorp Packer in Azure
FROM registry.fedoraproject.org/fedora-toolbox:41

# Add the Packer repo so you can install Packer
# https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli
RUN dnf config-manager addrepo --from-repofile https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

# Add the key and repo so you can install Powershell
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc
RUN curl https://packages.microsoft.com/config/rhel/9/prod.repo | tee /etc/yum.repos.d/microsoft.repo

RUN dnf -y install packer powershell python3 python3-pip python3-virtualenv

# https://developer.hashicorp.com/packer/integrations/hashicorp/azure
RUN packer plugins install github.com/hashicorp/azure
