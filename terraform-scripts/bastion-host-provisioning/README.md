Bastion Module and Provisioning through a Bastion Host

a sub module for creating a bastion host instance with public ip and private ip network connection, enabled for ssh
provisioning to the private instance through the bastion host
separate ssh key pairs for the bastion host and private instance
Prerequisites
Create separate ssh key pairs for the bastion host and the private instances

$ ssh-keygen -f ./bastion_id_rsa -N "" -q

$ ssh-keygen -f ./instance_id_rsa -N "" -q
