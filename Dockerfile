FROM python:3.12-slim AS base

ARG DEBIAN_FRONTEND=noninteractive
ARG TINI_VERSION='v0.19.0'

ARG VIRTUAL_ENV=/app/.venv
ENV VIRTUAL_ENV=${VIRTUAL_ENV}
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV TINI_VERSION=${TINI_VERSION}

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /tini /usr/bin/entrypoint.sh

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    software-properties-common \
    ffmpeg \
    git

VOLUME /root/.cache/
WORKDIR /app

ENTRYPOINT ["/tini", "--", "/usr/bin/entrypoint.sh"]
CMD ["python", "/app/app.py"]


FROM base AS cudnn

ARG CUDNN_VERSION=12

### Configure Cuda Passthrough
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV CUDNN_VERSION=${CUDNN_VERSION}
ENV HF_TOKEN='hf_REPLACE_ME'

### Install libcudnn - https://developer.nvidia.com/cudnn-downloads?target_os=Linux&target_arch=x86_64&Distribution=Debian&target_version=12&target_type=deb_network
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    add-apt-repository contrib && \
    apt-get update && \
    apt-get -y install cudnn-cuda-${CUDNN_VERSION} && \
    rm -rf /var/lib/apt/lists/*
