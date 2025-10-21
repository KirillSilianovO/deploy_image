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
  tags       = [
    "${IMAGE_NAMESPACE}:${VERSION}",
    "${IMAGE_NAMESPACE}:latest"
  ]
}

target "load_local" {
  inherits = ["base"]
  output   = ["type=docker"]
}

target "push_dockerhub" {
  inherits  = ["base"]
  platforms = ["linux/amd64", "linux/arm64"]
  output    = ["type=registry,name=docker.io"]
}