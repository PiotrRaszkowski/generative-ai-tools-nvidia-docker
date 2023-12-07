FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt install -y git curl

RUN apt install -y python3.10-dev python3.10-tk python3-html5lib python3-apt python3-pip python3.10-distutils python3.10-venv
RUN apt install -y python-is-python3
RUN apt install -y pip

ARG FACEFUSION_VERSION=2.0.0

#Install TMalloc
RUN apt install -y libgoogle-perftools-dev

#Install required tools
RUN apt install -y libgl1
RUN apt install -y libglib2.0-0 libsm6 libxrender1 libxext6
RUN apt install -y ffmpeg

#RUN apt install -y libcublas11 libcufft10
#RUN apt install -y libnvrtc11.2

#Create new user
RUN useradd -ms /bin/bash appuser

WORKDIR /home/appuser
USER appuser
ENV HOME /home/appuser

#Install facefussion
RUN git clone https://github.com/facefusion/facefusion.git --branch ${FACEFUSION_VERSION} --single-branch facefusion

VOLUME /home/appuser/facefusion
WORKDIR /home/appuser/facefusion

ENV PATH="/home/appuser/.local/bin:$PATH"

RUN python -m pip install --upgrade pip

RUN python install.py --torch cuda --onnxruntime cuda

RUN cd /home/appuser/.local/lib/python3.10/site-packages/torch/lib && ln -s libnvrtc-672ee683.so.11.2 libnvrtc.so

ENV GRADIO_SERVER_NAME=0.0.0.0

EXPOSE 7860
CMD python run.py --execution-providers cuda --max-memory 4
