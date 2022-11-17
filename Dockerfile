ARG pythonlabel=3.10-bullseye
FROM python:${pythonlabel}

ARG TARGETPLATFORM
ARG TORCHTAG=v1.13.0
ARG GITHUB_USER=maxisoft

ENV DEBIAN_FRONTEND=noninteractive NO_CUDA=1 NO_DISTRIBUTED=1 NO_MKLDNN=1 USE_NCCL=0 BUILD_TEST=0
VOLUME [ "/out" ]
WORKDIR /src/torch
RUN apt-get update && apt-get install -y \
  automake autoconf libpng-dev nano \
  curl zip unzip libtool swig zlib1g-dev pkg-config git wget xz-utils \
  libopenblas-dev libblas-dev m4 cmake g++ gcc libssl-dev build-essential && \
  git clone --depth 100 -b ${TORCHTAG} -- https://github.com/pytorch/pytorch.git && \
  cd pytorch && \
  git submodule update --init --recursive --depth 100 && \
  python -m pip install -U pyyaml future mock wheel cython && \
  python -m pip install -r requirements.txt && \
  python setup.py build

ENTRYPOINT [ "/bin/bash", "cp", "--archive", "/src/torch/build", "/out" ]
