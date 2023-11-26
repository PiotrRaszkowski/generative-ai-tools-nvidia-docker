ARG BUILD_VERSION=x86_64

FROM ubuntu:22.04 as automatic1111-base

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y ubuntu-server

#Install TMalloc
RUN apt install -y libgoogle-perftools-dev

#Install required base packages
RUN apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git

FROM automatic1111-base as automatic1111-base-x86_64

#Install Nvidia CUDA
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
RUN dpkg -i cuda-keyring_1.1-1_all.deb

RUN apt update
RUN apt install -y cuda-toolkit

#ENV PATH=$PATH:/usr/local/cuda/bin
#ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

#ENV PATH /usr/local/cuda/bin${PATH:+:${PATH}}
#ENV LD_LIBRARY_PATH /usr/local/cuda-12.2/lib64\
#                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}

RUN nvcc -V

#Install cuDNN
ENV cuda_version=cuda12.2
ENV cudnn_version=8.9.6.*
RUN apt-get install libcudnn8=${cudnn_version}-1+${cuda_version}
RUN apt-get install libcudnn8-dev=${cudnn_version}-1+${cuda_version}
RUN apt-get install libcudnn8-samples=${cudnn_version}-1+${cuda_version}

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV CUDA_MODULE_LOADING=LAZY

#ENV SAFETENSORS_FAST_GPU=1
#ENV TORCH_ALLOW_TF32_CUBLAS_OVERRIDE=1
#ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics
#ENV NVIDIA_REQUIRE_CUDA="cuda>=11.6 driver>=450"

FROM automatic1111-base as automatic1111-base-arm64

FROM automatic1111-base-${BUILD_VERSION}

#Create new user
RUN useradd -ms /bin/bash automatic1111

WORKDIR /home/automatic1111
USER automatic1111
ENV HOME /home/automatic1111

#Install pyenv
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv

ENV PYENV_ROOT $HOME/.pyenv
RUN echo "$PYENV_ROOT"

ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN echo "$PATH"

RUN pyenv --version

#Install Python 3.10
RUN pyenv install 3.10
RUN pyenv global 3.10
RUN pyenv version
RUN python --version

#Install automatic1111
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui
VOLUME /home/automatic1111/stable-diffusion-webui
WORKDIR /home/automatic1111/stable-diffusion-webui

ADD webui-user.sh .

ENV USE_XFORMERS false
ENV IS_MACOS false
ENV USE_CUDA_121 true

RUN cat webui-user.sh

RUN python -m venv venv
ENV PATH="./venv/bin:$PATH"
RUN echo "$PATH"

RUN pip install --upgrade pip

RUN pip install -U xformers --index-url https://download.pytorch.org/whl/cu121

EXPOSE 7860
ENTRYPOINT [ "./webui.sh" ]