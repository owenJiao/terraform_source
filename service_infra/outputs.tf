output "kube_config" {
  value = module.cce.kube_config
  description = "CCE kube config"
}

output "elb_public_ip" {
   value = module.elb.elb_public_ip
   description = "ELB pubic ip"
}

# output "rds_private_ips" {
#    value = module.rds.private_ips
#    description = "RDS private ip"
# }

# output "rds_public_ips" {
#    value = module.rds.public_ips
#    description = "RDS pubic ip"
# }

output "elb_info" {
   value = module.elb
   description = "Elb info"
}


