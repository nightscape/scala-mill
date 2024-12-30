group "default" {
  targets = ["image-all"]
}

target "docker-metadata-action" {}

variable "BASE_IMAGE" {
  default = "ghcr.io/graalvm/graalvm/graalvm-ce:latest"
}
variable "SCALA_VERSION" {
  default = null
}
variable "MILL_VERSION" {
  default = null
}

target "image" {
  inherits = ["docker-metadata-action"]
  context = "./"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
}

target "test" {
  target = "test"
  output = ["type=cacheonly"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
}


target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
}
