resource "kubernetes_pod" "pod" {
  metadata {
    name = "pod"
  }
  spec {
    container {
      image = "nginx:1.19.4-alpine"
      name  = "nginx"
    }

  }

}