#!/bin/bash

# Variables
RESOURCE_GROUP="MyAKSResourceGroup"
LOCATION="eastus"
VNET_NAME="MyAKSVNet"
SUBNET_NAME="MyAKSSubnet"
SUBNET_CIDR="10.0.0.0/24"
AKS_CLUSTER_NAME="MyAKSCluster"
NODE_COUNT=2
NODE_VM_SIZE="Standard_D2s_v3"
KUBERNETES_VERSION="1.28.2"  # Get latest version using: az aks get-versions --location eastus --query "orchestrators[-1].orchestratorVersion" -o tsv
SERVICE_CIDR="10.1.0.0/16"
DNS_SERVICE_IP="10.1.0.10"

# Create Resource Group
echo "Creating Resource Group: $RESOURCE_GROUP..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create Virtual Network
echo "Creating Virtual Network: $VNET_NAME..."
az network vnet create \
  --resource-group $RESOURCE_GROUP \
  --name $VNET_NAME \
  --address-prefix 10.0.0.0/16

# Create Subnet for AKS
echo "Creating Subnet: $SUBNET_NAME..."
az network vnet subnet create \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $VNET_NAME \
  --name $SUBNET_NAME \
  --address-prefix $SUBNET_CIDR

# Get Subnet ID
SUBNET_ID=$(az network vnet subnet show --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $SUBNET_NAME --query "id" -o tsv)

# Create AKS Cluster
echo "Creating AKS Cluster: $AKS_CLUSTER_NAME..."
az aks create \
  --resource-group $RESOURCE_GROUP \
  --name $AKS_CLUSTER_NAME \
  --node-count $NODE_COUNT \
  --node-vm-size $NODE_VM_SIZE \
  --kubernetes-version $KUBERNETES_VERSION \
  --network-plugin azure \
  --vnet-subnet-id $SUBNET_ID \
  --service-cidr $SERVICE_CIDR \
  --dns-service-ip $DNS_SERVICE_IP \
  --generate-ssh-keys

echo "AKS Cluster '$AKS_CLUSTER_NAME' created successfully!"

# Get AKS Credentials
echo "Fetching AKS credentials..."
az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME

echo "AKS is ready! Use 'kubectl get nodes' to check the cluster status."
======================
# to use existing RG
#!/bin/bash

# Variables
RESOURCE_GROUP="kml_rg_main-f9d2bf8d2f994ff5"
LOCATION="eastus"
VNET_NAME="MyAKSVNet"
SUBNET_NAME="MyAKSSubnet"
SUBNET_CIDR="10.0.0.0/24"
AKS_CLUSTER_NAME="MyAKSCluster"
NODE_COUNT=2
NODE_VM_SIZE="Standard_D2s_v3"
KUBERNETES_VERSION="1.28.2"  # Get latest version using: az aks get-versions --location eastus --query "orchestrators[-1].orchestratorVersion" -o tsv
SERVICE_CIDR="10.1.0.0/16"
DNS_SERVICE_IP="10.1.0.10"


# Create Virtual Network
echo "Creating Virtual Network: $VNET_NAME..."
az network vnet create \
  --resource-group $RESOURCE_GROUP \
  --name $VNET_NAME \
  --address-prefix 10.0.0.0/16

# Create Subnet for AKS
echo "Creating Subnet: $SUBNET_NAME..."
az network vnet subnet create \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $VNET_NAME \
  --name $SUBNET_NAME \
  --address-prefix $SUBNET_CIDR

# Get Subnet ID
SUBNET_ID=$(az network vnet subnet show --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $SUBNET_NAME --query "id" -o tsv)

# Create AKS Cluster

echo "Creating AKS Cluster: $AKS_CLUSTER_NAME..."

# az aks create   --resource-group kml_rg_main-f9d2bf8d2f994ff5   --name MyAKSCluster   --node-count 2   --node-vm-size Standard_D2s_v3   --enable-managed-identity   --generate-ssh-keys
az aks create \
  --resource-group $RESOURCE_GROUP \
  --name $AKS_CLUSTER_NAME \
  --node-count $NODE_COUNT \
  --node-vm-size $NODE_VM_SIZE \
  --kubernetes-version $KUBERNETES_VERSION \
  --network-plugin azure \
  --vnet-subnet-id $SUBNET_ID \
  --service-cidr $SERVICE_CIDR \
  --dns-service-ip $DNS_SERVICE_IP \
  --generate-ssh-keys

echo "AKS Cluster '$AKS_CLUSTER_NAME' created successfully!"

# Get AKS Credentials
echo "Fetching AKS credentials..."
az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME

echo "AKS is ready! Use 'kubectl get nodes' to check the cluster status."
