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

FROM python3.10-base as kohya_ss
#https://github.com/AUTOMATIC1111/stable-diffusion-webui

ARG KOHYA_SS_VERSION=v22.2.1

#Install TMalloc
RUN apt install -y libgoogle-perftools-dev

#Create new user
RUN useradd -ms /bin/bash appuser

WORKDIR /home/appuser
USER appuser
ENV HOME /home/appuser

#Install kohya_ss
RUN git clone https://github.com/bmaltais/kohya_ss.git --branch ${KOHYA_SS_VERSION} --single-branch .
VOLUME /home/appuser/kohya_ss
WORKDIR /home/appuser/kohya_ss

RUN python3 -m venv venv
ENV PATH="./venv/bin:$PATH"

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install wheel rich

COPY requirements_linux.txt .

RUN ./setup.sh

#RUN python3 -m pip install -U torch==2.1.0+cu121 torchvision==0.16.1+cu121 --extra-index-url https://download.pytorch.org/whl/cu121
#RUN python3 -m pip install -U xformers --index-url https://download.pytorch.org/whl/cu121

ENV LD_PRELOAD=libtcmalloc.so

EXPOSE 7860
CMD "./gui.sh" --listen 0.0.0.0 --server_port 7860