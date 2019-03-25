resource "opc_compute_security_list" "opt_sec_list_1" {
  name                 = "sec_list_1"
}

resource "opc_compute_security_list" "opt_sec_list_2" {
  name                 = "sec_list_2"
}

resource "opc_compute_security_application" "jenkinshttp" {
  name     = "jenkinshttp"
  protocol = "tcp"
  dport    = "8080"
}

resource "opc_compute_security_application" "jenkinshttps" {
  name     = "jenkinshttps"
  protocol = "tcp"
  dport    = "8443"
}

resource "opc_compute_security_application" "postgres" {
  name     = "postgres"
  protocol = "tcp"
  dport    = "5432"
}

resource "opc_compute_security_application" "oct_sec_application_docker" {
  name     = "docker"
  protocol = "tcp"
  dport    = "5000"
}


resource "opc_compute_sec_rule" "allow-ssh" {
  name             = "allow_ssh_access"
  source_list      = "seclist:${opc_compute_security_list.opt_sec_list_1.name}"
  destination_list = "seclist:${opc_compute_security_list.opt_sec_list_2.name}"
  action           = "permit"
  application      = "/oracle/public/rdp"
  disabled         = false
}

resource "opc_compute_sec_rule" "allow-rdp" {
  name             = "allow_rdp_access"
  source_list      = "seclist:${opc_compute_security_list.opt_sec_list_1.name}"
  destination_list = "seclist:${opc_compute_security_list.opt_sec_list_2.name}"
  action           = "permit"
  application      = "/oracle/public/rdp"
  disabled         = false
}

resource "opc_compute_sec_rule" "allow-http" {
  name             = "allow_http_access"
  source_list      = "seclist:${opc_compute_security_list.opt_sec_list_1.name}"
  destination_list = "seclist:${opc_compute_security_list.opt_sec_list_2.name}"
  action           = "permit"
  application      = "/oracle/public/http"
  disabled         = false
}

resource "opc_compute_sec_rule" "allow-https" {
  name             = "allow_https_access"
  source_list      = "seclist:${opc_compute_security_list.opt_sec_list_1.name}"
  destination_list = "seclist:${opc_compute_security_list.opt_sec_list_2.name}"
  action           = "permit"
  application      = "/oracle/public/https"
  disabled         = false
}

resource "opc_compute_sec_rule" "allow-ldap" {
  name             = "allow_ldap_access"
  source_list      = "seclist:${opc_compute_security_list.opt_sec_list_1.name}"
  destination_list = "seclist:${opc_compute_security_list.opt_sec_list_2.name}"
  action           = "permit"
  application      = "/oracle/public/ldap"
  disabled         = false
}

resource "opc_compute_sec_rule" "allow-jenkinshttp" {
  name             = "allow_jenkins_http_access"
  source_list      = "seclist:${opc_compute_security_list.opt_sec_list_1.name}"
  destination_list = "seclist:${opc_compute_security_list.opt_sec_list_2.name}"
  action           = "permit"
  application      = "/Compute-${var.domain}/${var.username}/jenkinshttp"
  disabled         = false
}

resource "opc_compute_sec_rule" "allow-jenkinshttps" {
  name             = "allow_jenkins_https_access"
  source_list      = "seclist:${opc_compute_security_list.opt_sec_list_1.name}"
  destination_list = "seclist:${opc_compute_security_list.opt_sec_list_2.name}"
  action           = "permit"
  application      = "/Compute-${var.domain}/${var.username}/jenkinshttps"
  disabled         = false
}

resource "opc_compute_sec_rule" "allow-postgres" {
  name             = "allow_postgres_access"
  source_list      = "seclist:${opc_compute_security_list.opt_sec_list_1.name}"
  destination_list = "seclist:${opc_compute_security_list.opt_sec_list_2.name}"
  action           = "permit"
  application      = "/Compute-${var.domain}/${var.username}/postgres"
  disabled         = false
}

resource "opc_compute_sec_rule" "allow-docker" {
  name             = "allow_docker_access"
  source_list      = "seclist:${opc_compute_security_list.opt_sec_list_1.name}"
  destination_list = "seclist:${opc_compute_security_list.opt_sec_list_2.name}"
  action           = "permit"
  application      = "/Compute-${var.domain}/${var.username}/docker"
  disabled         = false
}
