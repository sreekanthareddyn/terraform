Single instance with public SSH access
This script launches a single instance with a public IP address and enables ssh access

This script creates:

a single Oracle Linux instance tony-instance1
an SSH Key to that will be enabled on the instance example-sshkey1
a public ip reservation on the Shared network interface
a new security list example-seclist1 and associates the security list to instances Shared Network interface.
Creates a new Allow-ssh-access security rule to allow SSH traffic from the public internet to the tony-seclist1 security list.
Usage
First create a terraform.tfvars to file to set your environment specific preferences

user = "tony@pippo.com"
password = "XXXXXXXX"
domain = "usexample54321"
endpoint = "https://api-z27.compute.us6.oraclecloud.com/"

Generate an SSH Key
The default configuraiton assumes that files for the id_rsa.pub and id_rsa ssh public private key pair are in the local directory. This is the SSH key that will used to access the instance. Gerneate a new SSH key file using ssh-keygen or set the variable ssh-private_key_file in the terraform.tfvars file.

$ ssh-keygen -f ./id_rsa -N "" -q
Apply the configuraiton
Check and apply the configuraiton to create the instance

$ terraform init
$ terraform plan
$ terraform apply
Login to the instance once is has fully started.

Access the instance
You can find the Public IP Address that was assigned to the instance in the Oracle Compute Cloud console, or inspect the terraform configuration for the opc_compute_ip_reservation.ipreservation1.ip

$ terraform show | grep -A 2 opc_compute_ip_reservation.ipreservation1
opc_compute_ip_reservation.ipreservation1:
  id = 8ee43eb8-ded1-4c41-9578-b301425ed5e7
  ip = 129.152.148.130
To ssh to the instance using the SSH Key that was provisioned

ssh opc@129.152.148.130 -i id_rsa
Delete ths instance
terraform destroy
