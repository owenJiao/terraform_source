# -------  vpc module -------

# variable "vpc_name" {
#   description = "Vpc name"
#   default = "vela-vpc"
#   type = string
# }

# variable "vpc_cidr" {
#   description = "Vpc CIDR block"
#   default = "192.168.0.0/16"
#   type = string
# }

# variable "subnet_name" {
#   description = "Subnet name"
#   default = "vela-subnet"
#   type = string
# }

# variable "subnet_cidr" {
#   description = "Subnet CIDR block"
#   default = "192.168.0.0/24"
#   type = string
# }

# variable "availability_zone" {
#   description = "Availability zone"
#   default = ""
#   type = string
# }

# variable "subnet_gateway_ip" {
#   description = "Subnet gateway ip"
#   default = "192.168.0.1"
#   type = string
# }

# variable "primary_dns" {
#   description = "Primary dns"
#   default = "100.125.1.250"
#   type = string
# }

# variable "secondary_dns" {
#   description = "Secondary dns"
#   default = "100.125.21.250"
#   type = string
# }

# variable "eni_subnet_name" {
#   description = "ENI Subnet name"
#   default = "vela-eni"
#   type = string
# }

# variable "eni_subnet_cidr" {
#   description = "ENI Subnet cidr"
#   default = "192.168.2.0/24"
#   type = string
# }

# variable "eni_subnet_gateway_ip" {
#   description = "ENI Subnet gateway ip"
#   default = "192.168.2.1"
#   type = string
# }


# # -------  eip module -------

# variable "eip_name" {
#   description = "EIP name"
#   default = "vela-eip"
#   type = string
# }

# variable "eip_type" {
#   description = "EIP type"
#   default = "5_bgp"
#   type = string
# }

# variable "bandwidth_name" {
#   description = "Bandwidth name"
#   default = "vela-bw"
#   type = string
# }



# -------  cce  -------

variable "cluster_name" {
  description = "Cluster name"
  default = "vela-cce"
  type = string
}

variable "flavor_id" {
  description = "Flavor id"
  default = "cce.s2.small"
  type = string
}

variable "vpc_id" {
  description = "vpc id"
  type = string
}

variable "subnet_id" {
  description = "subnet id"
  type = string
}

variable "network_type" {
  description = "Network type"
  default = "eni"
  type = string
}

variable "eni_subnet_id" {
  description = "Eni subnet id"
  type = string
}

variable "eni_subnet_cidr" {
  description = "Eni subnet cidr"
  type = string
}

variable "eip_address" {
  description = "Eip address"
  type = string
}


variable "cluster_version" {
  description = "Cluster version"
  default = "v1.23"
  type = string
}

variable "container_network_cidr" {
  description = "Container network cidr"
  default = "192.168.0.0/24"
  type = string
}

variable "service_network_cidr" {
  description = "Service network cidr"
  default = "10.247.0.0/16"
  type = string
}

variable "autoscaler_version" {
  description = "Autoscaler version"
  default = "1.23.17"
  type = string
}

variable "node_os" {
  description = "Node os"
  default = "CentOS 7.6"
  type = string
}

variable "initial_node_count" {
  description = "Initial node count"
  default = 2
  type = number
}

variable "node_password" {
  description = "Node password"
  default = "123@admin"
  type = string
}


variable "min_node_count" {
  description = "Min node count"
  default = 2
  type = number
}

variable "max_node_count" {
  description = "Max node count"
  default = 10
  type = number
}

variable "scale_down_cooldown_time" {
  description = "Scale down cooldown time"
  default = 100
  type = number
}

variable "priority" {
  description = "Node pool priority"
  default = 1
  type = number
}

variable "node_type" {
  description = "Node type"
  default = "vm" 
  type = string
}

variable "root_volume_size" {
  description = "Root volume size"
  default = 40
  type = number
}

variable "root_volume_volumetype" {
  description = "Root volume type"
  default = "SSD"
  type = string
}

variable "data_volumes_size" {
  description = "Data volume size"
  default = 100
  type = number
}

variable "data_volumes_volumetype" {
  description = "Data volume type"
  default = "SSD"
  type = string
}


variable "project_name" {
  description = "Project name"
  type = string
}

variable "availability_zone" {
  description = "Availability zone"
  type = string
}

variable "nodepool_flavor_id" {
  description = "Node pool flavor id"
  default = "c7.large.2"
  type = string
}

variable "elb_id" {
  description = "ELB id"
  type = string
}

variable "elb_ip" {
  description = "ELB ip"
  type = string
}


# variable "nodepool_performance_type" {
#   description = "Node pool performance_type"
#   default = "computingv3"
#   type = string
# }

# variable "nodepool_cpu_core_count" {
#   description = "Node pool cpu_core_count"
#   default = 2
#   type = number
# }

# variable "nodepool_memory_size" {
#   description = "Node pool memory_size"
#   default = 4
#   type = number
# }

