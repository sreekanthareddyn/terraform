Load Balancer Classic Terraform Configuration
This set of scripts demonstrates how to configure the Oracle Cloud Infrastructure Load Balancer Classic service using Terraform

The scripts creates a complete application deployment including the backend servers, and load balances the traffic across the deployed web applications. The configuration is split into several sub modules:

network creates the IP Network for the server and load balancer deployment
server_pool creates a requested number of Oracle Cloud Infrastructure Classic compute instances on the configured IP Network
webapp deploys an example web application to each of the provisioned server instances
security_rules creates the security rule resources used to configure the server SSH and web app port access rules.
load_balancer created the load balancer instances configured to balance the traffic between the servers in the server pool
Note these scripts assumes the load balancer is being setup to load balance a site at the fictional address tony.pippo.com. To see the load balancer actually working this dns_name variable should be set to a domain you have access to in order to update the public DNS CNAME record so the host is redirected to the load balancers canonical host name.

Steps
Generate an ssh key pair for use deploying this (no passphrase)

$ ssh-keygen -f ./id_rsa
Create a local terraform.tfvars file with your environment specific credentials

domain="55500000"
endpoint="https://compute.uscom-central-1.oraclecloud.com/"
user="tony@pippo.com"
password="Pa55_Word"
region="uscom-central-1"
lbaas_endpoint= "https://lbaas-11111111.balancer.oraclecloud.com"
Adjust the server_count and dns_names local variables if required.

Deploy the configuration

$ terraform apply
