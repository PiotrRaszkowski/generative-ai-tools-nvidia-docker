FROM ubuntu:22.04 as ubuntu-nvidia-cuda12.2

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y ubuntu-server

#Install TMalloc
RUN apt install -y libgoogle-perftools-dev

#Install Nvidia CUDA
RUN curl -O https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
RUN dpkg -i cuda-keyring_1.1-1_all.deb

RUN apt update
RUN apt install -y cuda-toolkit-12-2

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

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


FROM ubuntu-nvidia-cuda12.2 as python3.10-base

#Install required base packages
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update
RUN apt install -y git curl libgl1 libglib2.0-0 libgoogle-perftools-dev python3.10-dev python3.10-tk python3-html5lib python3-apt python3-pip python3.10-distutils python3.10-venv

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 3 && \
    update-alternatives --set python3 /usr/bin/python3.10

RUN apt install python-is-python3

RUN python3 --version
RUN python --version

#Create new user
RUN useradd -ms /bin/bash appuser

WORKDIR /home/appuser
USER appuser
ENV HOME /home/appuser

RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3

FROM python3.10-base as kohya_ss

#Install kohya_ss
RUN git clone https://github.com/bmaltais/kohya_ss.git
VOLUME /home/appuser/kohya_ss
WORKDIR /home/appuser/kohya_ss

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install wheel rich

RUN python3 -m pip install torch==2.1.0+cu121 --extra-index-url https://download.pytorch.org/whl/cu121
RUN python3 -m pip install -U xformers --index-url https://download.pytorch.org/whl/cu121

RUN ./setup.sh

# ENV LD_PRELOAD=libtcmalloc.so
# ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

#EXPOSE 7860
# CMD python3 "./kohya_gui.py" ${CLI_ARGS} --listen 0.0.0.0 --server_port 7860
CMD "./gui.sh" ${CLI_ARGS} --listen 0.0.0.0 --server_port 7860