resource "kubernetes_deployment" "simple_web" {
    metadata {
      name = "simple-web"
      labels = {
        app = "simple-web"
      }
    }

    spec {
      replicas = 1

      selector {
        match_labels = {
          app = "simple-web"
        }
      }

      template {
        metadata {
          labels = {
            app = "simple-web"
          }
        }

        spec {
          container {
            image = "yeasy/simple-web"
            name = "simple-web"

            port {
              container_port = 80
            }
          }
        }
      }
    }
}

resource "kubernetes_service" "simple_web" {
    metadata {
      name = "simple-web"
    }

    spec {
      selector = {
        app = "simple-web"
      }

      type = "LoadBalancer"

      port {
        port = 80
        target_port = 80
      }
    }
}