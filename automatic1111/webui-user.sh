#!/bin/bash
export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --enable-insecure-extension-access --listen --medvram --no-half-vae"
export LD_PRELOAD=libtcmalloc.so

if [ "$IS_MACOS" = "true" ]; then
    echo "Using MacOS configuration"
    export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --skip-torch-cuda-test --no-half --upcast-sampling --no-half-vae --use-cpu interrogate"
    export TORCH_COMMAND="pip install torch==2.1.0 torchvision==0.16.0"
    export PYTORCH_ENABLE_MPS_FALLBACK=1
else
   echo "Using standard Linux configuration"
   if [ "$USE_CUDA_121" = "true" ]; then
      echo "Using CUDA 121"
      export TORCH_COMMAND="pip install torch==2.1.0+cu121 --extra-index-url https://download.pytorch.org/whl/cu121"
   fi
fi

if [ "$USE_XFORMERS" = "true" ]; then
    echo "Using XFormers" 
    export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --xformers"
else 
   echo "Not using XFormers" 
fi