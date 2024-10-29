variable "IMAGE_NAMESPACE" {
  default = "$IMAGE_NAMESPACE"
}

variable "VERSION" {
  default = "$VERSION"
}

group "load" {
  targets = ["load_local"]
}

group "push" {
  targets = ["push_dockerhub"]
}

target "base" {
  dockerfile = "./Dockerfile"
  context    = "./"
  platforms   = ["linux/amd64", "linux/arm64"]
  tags       = [
    "${IMAGE_NAMESPACE}:${VERSION}",
    "${IMAGE_NAMESPACE}:latest"
  ]
}

target "load_local" {
  inherits = ["base"]
  platforms = []
  output   = ["type=docker"]
}

target "push_dockerhub" {
  inherits = ["base"]
  output   = ["type=registry,name=docker.io"]
}