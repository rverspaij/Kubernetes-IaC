resource "kubernetes_namespace" "demo" {
  metadata {
    name = "demo"
  }
}

resource "kubernetes_deployment" "hello" {
  metadata {
    name = "hello-app"
    namespace = kubernetes_namespace.demo.metadata[0].name
    labels = {
        app = "hello"
    }
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "hello"
      }
    }
    template {
      metadata {
        labels = {
          app = "hello"
        }
      }
      spec {
        container {
          name = "hello"
          image = "yeasy/simple-web"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hello" {
  metadata {
    name = "hello-service"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  spec {
    selector = {
        app = "hello"
    }

    port {
      port = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_v1" "hello" {
  metadata {
    name = "hello-ingress"
    namespace = kubernetes_namespace.demo.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.hello.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "helm_release" "argocd" {
  name = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  namespace = "argocd"
  create_namespace = true

  values = [
    file("argocd-values.yaml")
  ]

  depends_on = [ azurerm_kubernetes_cluster.k8s ]
}