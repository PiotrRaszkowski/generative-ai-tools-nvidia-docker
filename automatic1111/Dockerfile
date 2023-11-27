FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04 as python3.10-base

ENV DEBIAN_FRONTEND noninteractive

RUN uname -a

RUN apt update
RUN apt install -y git curl
RUN apt install -y python3.10-dev python3.10-tk python3-html5lib python3-apt python3-pip python3.10-distutils python3.10-venv
RUN apt install -y python-is-python3
RUN apt install -y pip

RUN python3 --version
RUN python --version

FROM python3.10-base as automatic1111

ARG AUTOMATIC1111_VERSION=v1.6.0

#Install TMalloc
RUN apt install -y libgoogle-perftools-dev

#Install required tools for automatic 1111
RUN apt install -y libgl1
RUN apt install -y libglib2.0-0 libsm6 libxrender1 libxext6

#Create new user
RUN useradd -ms /bin/bash appuser

WORKDIR /home/appuser
USER appuser
ENV HOME /home/appuser

#Install automatic1111
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui --branch ${AUTOMATIC1111_VERSION} --single-branch .
VOLUME /home/appuser/stable-diffusion-webui
WORKDIR /home/appuser/stable-diffusion-webui

ADD webui-user.sh .

ENV USE_XFORMERS false
ENV IS_MACOS false
ENV USE_CUDA_121 true

RUN cat webui-user.sh

RUN python3 -m venv venv
ENV PATH="./venv/bin:$PATH"

RUN pip install --upgrade pip

RUN pip install -U xformers --index-url https://download.pytorch.org/whl/cu121

EXPOSE 7860
ENTRYPOINT [ "./webui.sh" ]