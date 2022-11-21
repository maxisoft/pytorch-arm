# pytorch-arm
Use GitHub actions + Docker buildx to build recent **armv7/v8** (incl *rasberry-pi 2 and 4* compatibility) [pytorch](https://github.com/pytorch/pytorch) wheels

--------------

## TL;DR
```sh
# using debian:bullseye
apt-get install --no-install-recommends python3 python3-pip libblas3 libfftw3-3 libopenblas0 python3-typing-extensions
python3 -m pip install https://github.com/maxisoft/pytorch-arm/releases/download/v0.1.0/torch-1.13.0a0+git7c98e70-cp39-cp39-linux_armv7l.whl # change the url if needed

python3 -c 'import torch; print(torch.nn.Conv2d(8, 1, (3, 3))(torch.randn(4, 8, 3, 3)).squeeze_())'
```

## Requirements to install a pytorch working env
- python 3.9/3.10/3.11
- numpy 1.23
- openblas


## Notes
- The source code is built using python:3.X-buster (with the python version one of 3.9/3.10/3.11) docker hub image (due to [#1](https://github.com/maxisoft/pytorch-arm/issues/1)).
- One may needs numpy>=1.23<1.24 compatible version (wheels are also available for downloads) to call Tensor.numpy() method.

## Build features summary
```
******** Summary ********
General:
CMake version         : 3.13.4
CMake command         : /usr/bin/cmake
System                : Linux
C++ compiler          : /usr/bin/c++
C++ compiler id       : GNU
C++ compiler version  : 8.3.0
Using ccache if found : ON
Found ccache          : CCACHE_PROGRAM-NOTFOUND
CXX flags             :  -fvisibility-inlines-hidden -DUSE_PTHREADPOOL -fopenmp -DNDEBUG -DUSE_KINETO -DLIBKINETO_NOCUPTI -DUSE_QNNPACK -DUSE_PYTORCH_QNNPACK -DUSE_XNNPACK -DSYMBOLICATE_MOBILE_DEBUG_HANDLE -DEDGE_PROFILER_USE_KINETO -O2 -fPIC -Wno-narrowing -Wall -Wextra -Werror=return-type -Werror=non-virtual-dtor -Wno-missing-field-initializers -Wno-type-limits -Wno-array-bounds -Wno-unknown-pragmas -Wunused-local-typedefs -Wno-unused-parameter -Wno-unused-function -Wno-unused-result -Wno-strict-overflow -Wno-strict-aliasing -Wno-error=deprecated-declarations -Wno-stringop-overflow -Wno-psabi -Wno-error=pedantic -Wno-error=redundant-decls -Wno-error=old-style-cast -fdiagnostics-color=always -faligned-new -Wno-unused-but-set-variable -Wno-maybe-uninitialized -fno-math-errno -fno-trapping-math -Werror=format -Werror=cast-function-type -DMISSING_ARM_VST1 -Wno-stringop-overflow
Build type            : Release
Compile definitions   : ONNX_ML=1;ONNXIFI_ENABLE_EXT=1;ONNX_NAMESPACE=onnx_torch;HAVE_MMAP=1;_FILE_OFFSET_BITS=64;HAVE_SHM_OPEN=1;HAVE_SHM_UNLINK=1;HAVE_MALLOC_USABLE_SIZE=1;USE_EXTERNAL_MZCRC;MINIZ_DISABLE_ZIP_READER_CRC32_CHECKS
CMAKE_PREFIX_PATH     : /usr/local/lib/python3.11/site-packages
CMAKE_INSTALL_PREFIX  : /src/torch/pytorch/torch
USE_GOLD_LINKER       : OFF
TORCH_VERSION         : 1.13.0
CAFFE2_VERSION        : 1.13.0
BUILD_CAFFE2          : OFF
BUILD_CAFFE2_OPS      : OFF
BUILD_STATIC_RUNTIME_BENCHMARK: OFF
BUILD_TENSOREXPR_BENCHMARK: OFF
BUILD_NVFUSER_BENCHMARK: OFF
BUILD_BINARY          : OFF
BUILD_CUSTOM_PROTOBUF : ON
  Link local protobuf : ON
BUILD_DOCS            : OFF
BUILD_PYTHON          : True
  Python version      : 3.11
  Python executable   : /usr/local/bin/python
  Pythonlibs version  : 3.11.0
  Python library      : /usr/local/lib/libpython3.11.so.1.0
  Python includes     : /usr/local/include/python3.11
  Python site-packages: lib/python3.11/site-packages
BUILD_SHARED_LIBS     : ON
CAFFE2_USE_MSVC_STATIC_RUNTIME     : OFF
BUILD_TEST            : False
BUILD_JNI             : OFF
BUILD_MOBILE_AUTOGRAD : OFF
BUILD_LITE_INTERPRETER: OFF
INTERN_BUILD_MOBILE   : 
TRACING_BASED         : OFF
USE_BLAS              : 1
  BLAS                : open
  BLAS_HAS_SBGEMM     : 
USE_LAPACK            : 1
  LAPACK              : open
USE_ASAN              : OFF
USE_CPP_CODE_COVERAGE : OFF
USE_CUDA              : OFF
USE_ROCM              : OFF
USE_EIGEN_FOR_BLAS    : ON
USE_FBGEMM            : OFF
  USE_FAKELOWP          : OFF
USE_KINETO            : ON
USE_FFMPEG            : OFF
USE_GFLAGS            : 0
USE_GLOG              : 0
USE_LEVELDB           : OFF
USE_LITE_PROTO        : OFF
USE_LMDB              : 0
USE_METAL             : OFF
USE_PYTORCH_METAL     : OFF
USE_PYTORCH_METAL_EXPORT     : OFF
USE_MPS               : OFF
USE_FFTW              : ON
USE_MKL               : OFF
USE_MKLDNN            : 0
USE_UCC               : OFF
USE_ITT               : OFF
USE_NCCL              : 0
USE_NNPACK            : ON
USE_NUMPY             : ON
USE_OBSERVERS         : ON
USE_OPENCL            : OFF
USE_OPENCV            : OFF
USE_OPENMP            : ON
USE_TBB               : 1
  USE_SYSTEM_TBB      : OFF
USE_VULKAN            : OFF
USE_PROF              : OFF
USE_QNNPACK           : ON
USE_PYTORCH_QNNPACK   : ON
USE_XNNPACK           : ON
USE_REDIS             : 0
USE_ROCKSDB           : OFF
USE_ZMQ               : 0
USE_DISTRIBUTED       : ON
  USE_MPI               : 0
  USE_GLOO              : ON
  USE_GLOO_WITH_OPENSSL : OFF
  USE_TENSORPIPE        : ON
Public Dependencies  : caffe2::Threads
Private Dependencies : pthreadpool;cpuinfo;qnnpack;pytorch_qnnpack;nnpack;XNNPACK;fp16;tensorpipe;gloo;libzstd_static;foxi_loader;rt;fmt::fmt-header-only;kineto;gcc_s;gcc;dl
USE_COREML_DELEGATE     : OFF
BUILD_LAZY_TS_BACKEND   : ON
```

copy pasted from [b5529614](https://github.com/maxisoft/pytorch-arm/commit/b552961430a652284ee3e571bccdcef8fd55b898) build

## References
- https://github.com/PINTO0309/pytorch4raspberrypi
- https://zenn.dev/pinto0309/articles/b796e2d6396c1e
- https://stackoverflow.com/questions/65593177/how-to-build-libtorch-on-mac-arm
- https://github.com/KumaTea/ext-whl