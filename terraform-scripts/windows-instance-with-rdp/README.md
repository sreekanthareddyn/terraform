Terraform Configuration for Windows Server 2012 R2

Here we are lauching a single Windows 2012 R2 instance using the image from the Oracle Cloud Marketplace and enabled Remote Desktop access

Launches a new Windows Server 2012 R2 instance windows-server-1 with an initial Administrator password configured.
Creates a new public ip address reservation for the instance on the Shared Network interface
Creates a new security list windows-seclist1 and associates the security list to the instances Shared Network interface.
Creates a new Allow-rdp-access security rule to allow RDP traffic from the public internet to the windows-seclist1 security list.

Usage
Prerequisites
First we install the Microsoft Windows 2012 R2 image from the Oracle Cloud Marketplace in our Oracle Compute Cloud account/tenancy so the Windows Server image is available in our domain.

Create a terraform.tfvars to file to set our environment specific credentials

user = "tony@pippo.com"
password = "XXXXXXXX"
domain = "myexample54321"
endpoint = "https://api-z27.compute.us6.oraclecloud.com/"

administrator_password = "ADMINPA$$WORD#123"
Where adminstrator_password is the initial Windows Administrator password that will be set when lauching the Windows Server instance. If the administrator password is ommited from the terraform.tfvars it will be prompted for when applying the configuration, or can be set as an environment variable TF_VAR_administrator_password

Apply the configuration
First review the configuration plan of the resources that will be created.

$ terraform init
$ terraform plan
Then apply the configuration.

$ terraform apply
Access the server
Once the image has fully launched (this can take several minutes) connect to the instance using a Windows Remote Desktop Client. The Public IP Address that was assigned to the instance is output at the end of the terraform configuration for convinience.

output "public_ip" {
  value = "${opc_compute_ip_reservation.ipreservation1.ip}"
}
Login to the remote instance as \Administrator using the administrator password set when applying the configuration.

Clean-up
To destroy instance and clean-up all the dependent configuration

$ terraform destroy
