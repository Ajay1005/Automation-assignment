module "rgroup-n01656902" {
  source              = "./modules/rgroup-6902" 
  resource_group_name = "n01656902-RG"  
  location  = "Canada Central" 
}
module "network-n01656902" {
  source                = "./modules/network-6902"
  vnet_name             = "n01656902-VNET"
  vnet_address_space    = ["10.0.0.0/16"]
  location              = module.rgroup-n01656902.location
  resource_group_name   = module.rgroup-n01656902.resource_group_name
  subnet_name           = "n01656902-SUBNET"
  subnet_address_prefix = ["10.0.1.0/24"]
  nsg_name              = "n01656902-nsg"
}
module "common-n01656902" {
  source = "./modules/common-6902" 
  location            = module.rgroup-n01656902.location
  resource_group_name = module.rgroup-n01656902.resource_group_name
}

module "vmlinux-n01656902" {
  source              = "./modules/vmlinux-6902"
  location            = module.rgroup-n01656902.location
  resource_group_name = module.rgroup-n01656902.resource_group_name
  subnet_id           = module.network-n01656902.subnet_id
  storage_account_uri = module.common-n01656902.primary_blob_endpoint
  admin_username      = "n01656902"
  public_key     = "/home/n01656902/.ssh/id_rsa.pub"
  private_key    = "/home/n01656902/.ssh/id_rsa"
  linux_avs           = "Linux_avs"
  linux_vms           = { "linux-vm1" = "vm1dns", "linux-vm2" = "vm2dns", "linux-vm3" = "vm3dns" }
}

module "vmwindows-n01656902" {
  source              = "./modules/vmwindows-6902"
  resource_group_name = module.rgroup-n01656902.resource_group_name
  location            = module.rgroup-n01656902.location
  subnet_id           = module.network-n01656902.subnet_id
  storage_account_uri = module.common-n01656902.primary_blob_endpoint
  admin_username      = "n01656902"
  admin_password      = "Ajay1005" 
  windows_avs         = "Windows_avs"
}

module "datadisk-n01656902" {
  source              = "./modules/datadisk-6902"
  location            = module.rgroup-n01656902.location
  resource_group_name = module.rgroup-n01656902.resource_group_name
  linux_vm_ids        = module.vmlinux-n01656902.vm_ids
  windows_vm_id       = module.vmwindows-n01656902.vm_id[0]
}

module "loadbalancer-n01656902" {
  source              = "./modules/loadbalancer-6902"
  location            = module.rgroup-n01656902.location
  resource_group_name = module.rgroup-n01656902.resource_group_name
  linux_nic_ids       = module.vmlinux-n01656902.nic_ids
}
module "database-n01656902" {
  source              = "./modules/database-6902"
  location            = module.rgroup-n01656902.location
  resource_group_name = module.rgroup-n01656902.resource_group_name
  db_username         = "plsqladmin"
  db_password         = "Ajay1005"
}