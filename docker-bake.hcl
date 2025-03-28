group "default" {
  targets = ["base", "cudnn"]
}

target "base" {
  context = "."
  dockerfile = "Dockerfile"
  target = "base"
  tags = ["ghcr.io/${{ github.repository_owner }}/base-image:${{ version }}"]
}

target "cudnn" {
  context = "."
  dockerfile = "Dockerfile"
  target = "cudnn"
  tags = ["ghcr.io/${{ github.repository_owner }}/cudnn-image:${{ version }}"]
}