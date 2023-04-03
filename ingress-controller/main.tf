terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.9.0"
    }
  }
}

locals {
  helm_chart      = "ingress-nginx"
  helm_repository = "https://kubernetes.github.io/ingress-nginx"
}

provider "helm" {
  kubernetes {
    #config_path = "/Users/owenjiao/test/mykubeconfig/kubeconfig.json"
    #config_path = "~/.kube/config"
    #config_context = "docker-desktop"
    config_path = "./kubeconfig"
  }  
}

resource "helm_release" "ingress-nginx" {
  name             = var.ingress_release_name
  chart            = local.helm_chart
  namespace        = var.ingress_namespace
  repository       = local.helm_repository
  version          = var.ingress_chart_version
  create_namespace = var.ingress_create_namespace
  wait             = var.ingress_wait
  timeout          = var.ingress_timeout

  set {
    name  = "controller.ingressClassResource.name"
    value = var.ingress_class_name
  }

  set {
    name  = "controller.ingressClassResource.default"
    value = var.ingress_class_is_default
  }

  # set {
  #   name = "controller.service.loadBalancerIP"
  #   value = var.ingress_ip_address
  # }

  set {
    name = "defaultBackend.enabled"
    value = true
  }

  set {
    name = "defaultBackend.image.registry"
    value = "swr.cn-east-3.myhuaweicloud.com"
  }

  set {
    name = "defaultBackend.image.image"
    value = "hwofficial/defaultbackend"
  }

  set {
    name = "defaultBackend.image.tag"
    value = "1.5"
  }

  set {
    name = "controller.admissionWebhooks.enabled"
    value = false
  }

  set {
    name = "controller.image.registry"
    value = "swr.cn-east-3.myhuaweicloud.com"
  }

  set {
    name = "controller.image.image"
    value = "hwofficial/nginx-ingress"
  }

  set {
    name = "controller.image.tag"
    value = "v1.2.1"
  }

  set {
    name = "controller.image.digest"
    value = ""
  }

  set {
    name = "controller.image.digestChroot"
    value = ""
  }

  set {
    name = "controller.service.type"
    value = "NodePort"
  }

  set {
    name = "controller.service.nodePorts.http"
    value = "32080"
  }

  set {
    name = "controller.service.nodePorts.https"
    value = "32443"
  }

  

  # set {
  #   name = "controller.service.annotations.kubernetes\\.io/elb\\.id"
  #   value = var.elb_id
  # }

  # set {
  #   name = "controller.service.annotations.kubernetes\\.io/elb\\.class"
  #   value = "performance"
  # }
  
}
