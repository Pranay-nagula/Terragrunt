resource "azurerm_monitor_metric_alert" "PercentageCPU" {
  count = length(var.VMs)
  name                = "${var.VMs[count.index]} CPU hits 50"
  resource_group_name = "Terraform"
  scopes              = ["/subscriptions/{provide subscription ID}/resourceGroups/Terraform/providers/Microsoft.Compute/virtualMachines/${var.VMs[count.index]}"]
  description         = "${var.VMs[count.index]} CPU triggered at 50"
  target_resource_type = "Microsoft.Compute/virtualMachines"
  criteria { 
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 50
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag.id
  }
}
provider "azurerm" {
   features {}
}

terraform {
  backend "azurerm" {}
}

resource "azurerm_monitor_action_group" "ag" {
  name                = "Action_Grp"
  resource_group_name = "Terraform"
  short_name          = "ActionGroup"
  email_receiver {
    name          = "TestingTerra"
    email_address = "XXYYZZ@outlook.com"
  }
}

resource "azurerm_monitor_metric_alert" "DiskReadBytes" {
  count = length(var.VMs)
  name                = "${var.VMs[count.index]} Disk Hit maximum"
  resource_group_name = "Terraform"
  scopes              = ["/subscriptions/{provide subscription ID}/resourceGroups/Terraform/providers/Microsoft.Compute/virtualMachines/${var.VMs[count.index]}"]
  description         = "${var.VMs[count.index]} Disk Hits threshold value"
  target_resource_type = "Microsoft.Compute/virtualMachines"
  criteria { 
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Disk Read Bytes"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 6000000
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag.id
  }
}