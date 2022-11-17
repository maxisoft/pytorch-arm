ARG pythonlabel=3.10-bullseye
FROM python:${pythonlabel}

ARG TARGETPLATFORM
ARG TORCHTAG=v1.13.0
ARG GITHUB_USER=maxisoft

ENV DEBIAN_FRONTEND=noninteractive NO_CUDA=1 NO_DISTRIBUTED=1 NO_MKLDNN=1 USE_NCCL=0 BUILD_TEST=0 USE_ZSTD=1 USE_NUMPY=1 USE_SYSTEM_NCCL=0 USE_MPI=0 USE_GLOO=0 USE_TENSORPIPE=0 USE_DISTRIBUTED=0 USE_QNNPACK=1
VOLUME [ "/out" ]
WORKDIR /src/torch
RUN apt-get update && apt-get install -y \
  automake autoconf libpng-dev nano \
  curl zip unzip libtool swig zlib1g-dev pkg-config git wget xz-utils \
  libopenblas-dev libblas-dev m4 cmake g++ gcc libssl-dev build-essential && \
  git clone --depth 100 -b ${TORCHTAG} -- https://github.com/pytorch/pytorch.git && \
  cd pytorch && \
  git submodule update --init --recursive --depth 100 && \
  python -m pip install numpy -f https://ext.kmtea.eu/whl/stable.html --prefer-binary --no-index || python -m pip install --ignore-installed pyyaml numpy && \
  python -m pip install -U future mock wheel cython && \
  python -m pip install -r requirements.txt && \
  python setup.py build && \
  ls -lah build/ && \
  cd build/lib.*/torch || cd build/lib/torch && \
  ln -s _C.*.so _C.so || : && \
  ln -s _dl.*.so _dl.so || : && \
  ls -lah && \
  cd ../../.. && \
  python setup.py bdist_wheel && \
  python setup.py install


ENTRYPOINT [ "/bin/bash", "cp", "--archive", "/src/torch", "/out" ]
