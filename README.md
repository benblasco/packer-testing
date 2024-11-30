# How to created the Fedora Toolbx image

Execute the following command in the directory with the Containerfile to build a container image using Packer
```
buildah bud --squash -t packer .
```

# How to enter the toolbox

```
toolbox create -i localhost/packer:latest packertest
toolbox enter packertest
```

# Instructions for logging into Azure using the Azure CLI

TBC
