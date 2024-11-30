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

```
az login
```

Will give you a web link to authorise your session, which works well for me.


# Instructions for launching a VM

### When launching from a PAYG image

This works fine with the web console and the CLI. CLI obviously much quicker.

Command to create the image from the CLI
```
az vm create \
   --resource-group <RESOURCE GROUP> \
   --location australiasoutheast \
   --name vm-azure-rhel9-paygpacker \
   --admin-username azureuser \
   --ssh-key-value ~/.ssh/id_rsa.pub \
   --image azure-rhel9-payg-packer
```

### When launching from a BYOS image

You have to include the plan details even though they were embedded in the Packer JSON file.
If you try to create a VM from the web console it will fail with the error:
```
  "code": "VMMarketplaceInvalidInput",
  "message": "Creating a virtual machine from Marketplace image or a custom image sourced from a Marketplace image requires Plan information in the request. VM: '/subscriptions/5b0e2156-1afe-49c8-a4b4-ceca0603a2e4/resourceGroups/openenv-gh5fv/providers/Microsoft.Compute/virtualMachines/bblasco-rhel9-azure-byospacker'."
```
Command to create the image from the CLI
```
az vm create \
   --resource-group <RESOURCE GROUP> \
   --location australiasoutheast \
   --name vm-azure-rhel9-byospacker \
   --admin-username azureuser \
   --ssh-key-value ~/.ssh/id_rsa.pub \
   --image azure-rhel9-byos-packer \
   --plan-name rhel-lvm94-gen2 \
   --plan-product rhel-byos \
   --plan-publisher redhat
```

# Instructions for querying a VM

Get all the VMs in the resource group
```
az vm list --resource-group <RESOURCE GROUP>
```

Get info on a single VM (doesn't work for some reason)
```
az vm show --resource-group <RESOURCE GROUP> --name "vm-azure-rhel9-byos"
```

Get the licence type for all the instances:

```
az vm list --resource-group <RESOURCE GROUP> | grep -e '^    "name"\|"licenseType"'
```

Example output
```
    "licenseType": "RHEL_BYOS",
    "name": "vm-rhel9-azure-byos",
    "licenseType": null,
    "name": "vm-rhel9-azure-byospacker",
    "licenseType": null,
    "name": "vm-rhel9-azure-payg",
    "licenseType": null,
    "name": "vm-rhel9-azure-paygpacker",
    "licenseType": "RHEL_BYOS",
    "name": "vm-rhel9-azure-paygtobyos",
```
