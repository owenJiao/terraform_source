terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = "1.42.0"
    }
  }
}

locals {
  instance_name     = "k8s-node"
  kube_proxy_mode   = "ipvs"
  autoscaler_name = "autoscaler"
  nginx_ingress_name = "nginx-ingress"
  scall_enable = true
}

data "huaweicloud_identity_projects" "project" {
  name = "default"
}

# data "huaweicloud_compute_flavors" "flavor" {
#   availability_zone = var.availability_zone
#   performance_type  = var.nodepool_performance_type
#   cpu_core_count    = var.nodepool_cpu_core_count
#   memory_size       = var.nodepool_memory_size
# }

// TODO Need to create anyway
data "huaweicloud_cce_addon_template" "autoscaler" {
  cluster_id = huaweicloud_cce_cluster.cce_turbo.id
  name       = local.autoscaler_name
  version    = var.autoscaler_version
}

data "huaweicloud_cce_addon_template" "nginx_ingress" {
  cluster_id = huaweicloud_cce_cluster.cce_turbo.id
  name       = local.nginx_ingress_name
  version    = "2.1.3"
}


resource "random_string" "random" {
  length           = 5
  special          = false
}


resource "huaweicloud_cce_cluster" "cce_turbo" {
  name                   = var.cluster_name
  flavor_id              = var.flavor_id
  vpc_id                 = var.vpc_id
  subnet_id              = var.subnet_id
  container_network_type = var.network_type
  eni_subnet_id          = var.eni_subnet_id
  eni_subnet_cidr        = var.eni_subnet_cidr
  eip                    = var.eip_address
  cluster_version        = var.cluster_version
  container_network_cidr = var.container_network_cidr
  service_network_cidr   = var.service_network_cidr
  kube_proxy_mode        = local.kube_proxy_mode
  tags = {
    project = var.project_name
  }
}


resource "huaweicloud_cce_addon" "nginx-ingress" {
  cluster_id = huaweicloud_cce_cluster.cce_turbo.id
  template_name = "nginx-ingress"
  version    = "2.1.3"
  values {
    basic = jsondecode(data.huaweicloud_cce_addon_template.nginx_ingress.spec).basic
    custom_json = jsonencode(merge(
      jsondecode(data.huaweicloud_cce_addon_template.nginx_ingress.spec).parameters.custom,
      {
        "defaultBackend" = {
           "enabled": true
        },
        "service"= {
					"annotations"= {
						"kubernetes.io/elb.class"= "performance",
						"kubernetes.io/elb.id"= var.elb_id
					},
					"loadBalancerIP"= var.elb_ip
				}
      }
    ))
    flavor_json = jsonencode(merge(
      jsondecode(data.huaweicloud_cce_addon_template.nginx_ingress.spec).parameters.flavor1,
      {
        "replicas"= 2,
        "resources"= [{
          "limitsCpu"= "500m",
          "limitsMem"= "500Mi",
          "name"= "nginx-ingress",
          "requestsCpu"= "500m",
          "requestsMem"= "500Mi"
        }]
      }
    ))
  }
}


resource "huaweicloud_cce_addon" "autoscaler" {
  depends_on = [
    resource.huaweicloud_cce_node_pool.node_pool
  ]
  cluster_id    = huaweicloud_cce_cluster.cce_turbo.id
  template_name = data.huaweicloud_cce_addon_template.autoscaler.name
  version       = data.huaweicloud_cce_addon_template.autoscaler.version
  values {
    basic_json = jsonencode(jsondecode(data.huaweicloud_cce_addon_template.autoscaler.spec).basic)
    custom_json = jsonencode(
      merge(
        jsondecode(data.huaweicloud_cce_addon_template.autoscaler.spec).parameters.custom,
        {
          cluster_id       = huaweicloud_cce_cluster.cce_turbo.id
          tenant_id        = data.huaweicloud_identity_projects.project.id
        }
      )
    )
    flavor_json = jsonencode(jsondecode(data.huaweicloud_cce_addon_template.autoscaler.spec).parameters.flavor1)
  }
}


resource "huaweicloud_cce_node_pool" "node_pool" {
  cluster_id               = huaweicloud_cce_cluster.cce_turbo.id
  name                     = format("%s-%s-%s", var.project_name,local.instance_name,lower(random_string.random.result))
  os                       = var.node_os
  initial_node_count       = var.initial_node_count
  flavor_id                = var.nodepool_flavor_id//data.huaweicloud_compute_flavors.flavor.ids[1]
  availability_zone        = var.availability_zone
  password                 = var.node_password
  scall_enable             = local.scall_enable     
  min_node_count           = var.min_node_count
  max_node_count           = var.max_node_count
  scale_down_cooldown_time = var.scale_down_cooldown_time
  priority                 = var.priority
  type                     = var.node_type

  root_volume {
    size       = var.root_volume_size
    volumetype = var.root_volume_volumetype
  }
  data_volumes {
    size       = var.data_volumes_size
    volumetype = var.data_volumes_volumetype
  }

  tags = {
    project = var.project_name
  }

}


## Generate a kubeconfig file
resource "local_file" "kubeconfig" {
  filename = "./kubeconfig"
  content  = huaweicloud_cce_cluster.cce_turbo.kube_config_raw 
}

# resource "huaweicloud_cce_node" "node" {
#   count = var.node_count
#   cluster_id        = huaweicloud_cce_cluster.cce_turbo.id
#   name              = "${var.project_name}-${local.instance_name}-${random_string.random.result}-${count.index}"
#   flavor_id         = "s3.large.2"
#   availability_zone = var.availability_zone
#   password         = "123@jjxppp"
  
#   root_volume {
#     size       = 40
#     volumetype = "SSD"
#   }
#   data_volumes {
#     size       = 100
#     volumetype = "SSD"
#   }
# }

