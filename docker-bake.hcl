group "default" {
  targets = ["base", "cudnn"]
}

target "base" {
  context = "."
  dockerfile = "Dockerfile"
  target = "base"
  tags = ["ghcr.io/{{repository}}-base:{{version}}"]
}

target "cudnn" {
  context = "."
  dockerfile = "Dockerfile"
  target = "cudnn"
  tags = ["ghcr.io/{{repository}}-cudnn:{{version}}"]
}