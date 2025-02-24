#!/bin/bash

# Variables
RESOURCE_GROUP="MyResourceGroup"
LOCATION="eastus"
VNET_NAME="MyVNet"
SUBNET_NAME="MySubnet"
VM_NAME="MyLinuxVM"
VM_SIZE="Standard_B2s"
IMAGE="UbuntuLTS"
ADMIN_USER="azureuser"

# Create Resource Group
echo "Creating Resource Group: $RESOURCE_GROUP..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create Virtual Network
echo "Creating Virtual Network: $VNET_NAME..."
az network vnet create \
  --resource-group $RESOURCE_GROUP \
  --name $VNET_NAME \
  --address-prefix 10.0.0.0/16

# Create Subnet
echo "Creating Subnet: $SUBNET_NAME..."
az network vnet subnet create \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $VNET_NAME \
  --name $SUBNET_NAME \
  --address-prefix 10.0.0.0/24

# Create VM
echo "Creating Linux VM: $VM_NAME..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --image $IMAGE \
  --size $VM_SIZE \
  --admin-username $ADMIN_USER \
  --generate-ssh-keys \
  --vnet-name $VNET_NAME \
  --subnet $SUBNET_NAME

echo "VM creation complete!"
