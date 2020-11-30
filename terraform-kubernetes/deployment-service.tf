resource "kubernetes_namespace" "webapplication-namespace" {
  metadata {
    annotations = {
      name = "webapplication"
    }

    labels = {
      team = "42"
    }

    name = "webapplication"
  }
}

resource "kubernetes_deployment" "webapplication-deploy" {
  metadata {
    name = "webapplication"
    labels = {
      team = "42"
      app  = "frontend"
    }
    namespace = kubernetes_namespace.webapplication-namespace.id
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        team = "42"
        app  = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          team = "42"
          app = "frontend"
        }
      }

      spec {
        container {
          image = "nginx:1.19.4-alpine"
          name  = "frontend-app"

          }
        }
      }
    }
  }

resource "kubernetes_service" "webapplication-service" {
  metadata {
    name = "webapplication-service"
  }
  spec {
    selector = {
      app = "kubernetes_deployment.webapplication-deploy.metadata.labels.app"
    }
    port {
      port        = 8080
      target_port = 80
    }

    type = "NodePort"
  }
}