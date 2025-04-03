group "default" {
  targets = ["base", "cudnn"]
}

target "base" {
  context = "."
  dockerfile = "Dockerfile"
  target = "base"
}

target "cudnn" {
  context = "."
  dockerfile = "Dockerfile"
  target = "cudnn"
}