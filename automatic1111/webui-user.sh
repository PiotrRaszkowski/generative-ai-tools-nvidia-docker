#!/bin/bash
# https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Optimum-SDXL-Usage
# https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Optimizations

export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --enable-insecure-extension-access --listen"

if [ "$IS_LOWVRAM" = "true" ]; then
  export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --lowvram --opt-split-attention"
elif [ "$IS_MEDVRAM" = "true" ]; then
  export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --medvram"
fi

export LD_PRELOAD=libtcmalloc.so

echo "Using standard Linux configuration"
if [ "$USE_CUDA_118" = "true" ]; then
  echo "Using CUDA 118"
  export TORCH_COMMAND="pip install torch==2.1.1+cu118 --extra-index-url https://download.pytorch.org/whl/cu118"
fi

if [ "$USE_XFORMERS" = "true" ]; then
    echo "Using XFormers" 
    export COMMANDLINE_ARGS="$COMMANDLINE_ARGS --xformers"
else 
   echo "Not using XFormers" 
fi

echo "Command line args = ${COMMANDLINE_ARGS}"
