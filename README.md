# Python Humpback Docker Images
This repository contains Docker images for a Python-based application, with support for both a base environment and an environment configured for CUDA/cuDNN.

## Images

### Base Image
The `base` image provides a minimal Python environment with essential tools and dependencies for running the application.

### cuDNN Image
The `cudnn` image builds on the `base` image and includes NVIDIA CUDA and cuDNN libraries for GPU acceleration.

## Features

- **Base Image**:
  - Python 3.12 (slim variant)
  - Virtual environment setup
  - Common build tools (e.g., `build-essential`, `curl`, `git`)
  - Pre-installed `tini` as an init system
  - Configured entrypoint script for running Python applications

- **cuDNN Image**:
  - NVIDIA CUDA/cuDNN support
  - Configured for GPU passthrough with `NVIDIA_VISIBLE_DEVICES` and `NVIDIA_DRIVER_CAPABILITIES`

## Usage

### Pull the Images
```sh
docker pull ghcr.io/ai-dope/python-humpback-base:latest
```
```sh
docker pull ghcr.io/ai-dope/python-humpback-cudnn:latest
```

### Run Your App
Humpback runs your application through a volume mount on the `/app/` directory and by default will attempt to execute `python /app/app.py`, but this can be overridden with your own `CMD []` statement or post docker args. You can __optionally__ persist the python cache at `/root/.cache/` to wherever you'd like.

**Example**
```sh
cd repos/my_sweet_app/
docker container run -v /$(pwd)$:/app --runtime=nvidia ghcr.io/ai-dope/python-humpback-cudnn:latest python /app/main.py
```