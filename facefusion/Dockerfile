#FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04 as python3.10-base
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04 as python3.10-base

ENV DEBIAN_FRONTEND noninteractive

RUN uname -a

RUN apt update
RUN apt install -y git curl
RUN apt install -y python3.10-dev python3.10-tk python3-html5lib python3-apt python3-pip python3.10-distutils python3.10-venv
RUN apt install -y python-is-python3
RUN apt install -y pip

RUN python3 --version
RUN python --version

FROM python3.10-base as facefussion

ARG FACEFUSION_VERSION=1.3.1

#Install TMalloc
RUN apt install -y libgoogle-perftools-dev

#Install required tools for automatic 1111
RUN apt install -y libgl1
RUN apt install -y libglib2.0-0 libsm6 libxrender1 libxext6
RUN apt install -y ffmpeg

RUN ln -s /usr/local/cuda/targets/x86_64-linux/lib/libnvrtc.so.11.8.89 /usr/local/cuda/targets/x86_64-linux/lib/libnvrtc.so
ENV PATH=/usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

#Create new user
RUN useradd -ms /bin/bash appuser

WORKDIR /home/appuser
USER appuser
ENV HOME /home/appuser

#Install facefussion
RUN git clone https://github.com/facefusion/facefusion.git --branch ${FACEFUSION_VERSION} --single-branch facefusion

VOLUME /home/appuser/facefusion
WORKDIR /home/appuser/facefusion

RUN ls -lha

RUN python -m pip install --upgrade pip

RUN python install.py --torch cuda --onnxruntime cuda

#RUN python3 -m pip install -U torch==2.1.0+cu121 torchvision==0.16.1+cu121 --extra-index-url https://download.pytorch.org/whl/cu121
#RUN python3 -m pip install -U xformers --index-url https://download.pytorch.org/whl/cu121

ENV GRADIO_SERVER_NAME=0.0.0.0

EXPOSE 7860
CMD python run.py --execution-providers cuda