provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf_rs_blobstore"
    storage_account_name = "tfstorageigorsodre"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

variable "IMAGEBUILD" {
  type        = string
  description = "latest image build"
}

resource "azurerm_resource_group" "tf_test" {
  location = "Brazil South"
  name     = "tfmainrg"
}

resource "azurerm_container_group" "tfcg_test" {
  location            = azurerm_resource_group.tf_test.location
  name                = "terraform-practice-api"
  resource_group_name = azurerm_resource_group.tf_test.name
  os_type             = "Linux"
  ip_address_type     = "public"
  dns_name_label      = "igorsodrewa"

  container {
    cpu    = 1
    image  = "igorsodre/terraform-practice:${var.IMAGEBUILD}"
    memory = 1
    name   = "terraform-practice-api"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
