FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04 as python3.10-base

ENV DEBIAN_FRONTEND noninteractive

RUN uname -a

RUN apt update
RUN apt install -y git curl wget
RUN apt install -y python3.10-dev python3.10-tk python3-html5lib python3-apt python3-pip python3.10-distutils python3.10-venv
RUN apt install -y python-is-python3
RUN apt install -y pip

FROM python3.10-base as automatic1111vo

ARG AUTOMATIC1111_VERSION=v1.6.1

#Install TMalloc
RUN apt install -y libgoogle-perftools-dev

#Install required tools for automatic 1111
RUN apt install -y libgl1
RUN apt install -y libglib2.0-0 libsm6 libxrender1 libxext6
RUN apt install -y vim

#Create new user
RUN useradd -ms /bin/bash appuser

WORKDIR /home/appuser
USER appuser
ENV HOME /home/appuser
ENV PATH="/home/appuser/.local/bin:$PATH"

#Install automatic1111
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui --branch ${AUTOMATIC1111_VERSION} --single-branch

VOLUME /home/appuser/stable-diffusion-webui
WORKDIR /home/appuser/stable-diffusion-webui

# Models
WORKDIR /home/appuser/stable-diffusion-webui/models/Stable-diffusion

# epiCPhotoGasm - Last Unicorn
RUN wget --content-disposition 'https://huggingface.co/reszkapl/reszkaplmodels/resolve/main/epicphotogasm_lastUnicorn.safetensors?download=true'

# Realistic Vision V6.0 B1 - V6.0 B1 (VAE)
RUN wget --content-disposition 'https://huggingface.co/reszkapl/reszkaplmodels/resolve/main/realisticVisionV60B1_v60B1VAE.safetensors?download=true'

# RunDiffusionXL - beta
RUN wget --content-disposition 'https://huggingface.co/reszkapl/reszkaplmodels/resolve/main/rundiffusionXL_beta.safetensors?download=true'

# Juggernaut XL - V7 + RunDiffusion
RUN wget --content-disposition 'https://huggingface.co/reszkapl/reszkaplmodels/resolve/main/juggernautXL_v7Rundiffusion.safetensors?download=true'

# RealLife - v3.0
RUN wget --content-disposition 'https://huggingface.co/reszkapl/reszkaplmodels/resolve/main/reallife_v30.safetensors?download=true'

# RealCartoon-XL - v5
RUN wget --content-disposition 'https://huggingface.co/reszkapl/reszkaplmodels/resolve/main/realcartoonXL_v5.safetensors?download=true'

RUN ls -lha

WORKDIR /home/appuser/stable-diffusion-webui/extensions

#Deforum ART
RUN git clone https://github.com/deforum-art/deforum-for-automatic1111-webui

#Additional Networks
RUN git clone https://github.com/kohya-ss/sd-webui-additional-networks

# Control Net
# https://github.com/Mikubill/sd-webui-controlnet
# https://github.com/Mikubill/sd-webui-controlnet/discussions/2039
RUN git clone https://github.com/Mikubill/sd-webui-controlnet

#Civitai Browser Plus
RUN git clone https://github.com/BlafKing/sd-civitai-browser-plus

#Animated Diff
RUN git clone https://github.com/continue-revolution/sd-webui-animatediff

# posex
RUN git clone https://github.com/hnmr293/posex

# stable-diffusion-webui-images-browser
RUN git clone https://github.com/AlUlkesh/stable-diffusion-webui-images-browser

# Reactor (Face Swap)
RUN git clone https://github.com/Gourieff/sd-webui-reactor.git

# Roop (Face Swap)
RUN git clone https://github.com/s0md3v/sd-webui-roop.git

# SD WebUI Aspect Ratio Helper
RUN git clone https://github.com/thomasasfk/sd-webui-aspect-ratio-helper.git

#Control Net models
WORKDIR /home/appuser/stable-diffusion-webui/extensions/sd-webui-controlnet/models

RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_full.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_mid.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_small.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_depth_full.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_depth_mid.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_depth_small.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/ioclab_sd15_recolor.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/ip-adapter_sd15.pth'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/ip-adapter_sd15_plus.pth'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/ip-adapter_xl.pth'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_depth_anime.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_canny_anime.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_scribble_anime.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_openpose_anime.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_openpose_anime_v2.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_blur_anime_beta.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_blur_anime.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_blur.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_canny.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/kohya_controllllite_xl_depth.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_canny_128lora.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_canny_256lora.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_depth_128lora.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_depth_256lora.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_recolor_128lora.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_recolor_256lora.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_sketch_128lora.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sai_xl_sketch_256lora.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sargezt_xl_depth.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sargezt_xl_depth_faid_vidit.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sargezt_xl_depth_zeed.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/sargezt_xl_softedge.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_xl_canny.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_xl_openpose.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_xl_sketch.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_canny.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_depth_midas.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_depth_zoe.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_lineart.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_openpose.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_sketch.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/thibaud_xl_openpose.safetensors'
RUN wget --content-disposition 'https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/thibaud_xl_openpose_256lora.safetensors'

RUN ls -lha

#Animatediff models
WORKDIR /home/appuser/stable-diffusion-webui/extensions/sd-webui-animatediff/model

RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/mm_sd_v14.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/mm_sd_v15.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/mm_sd_v15_v2.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/mm_sdxl_v10_beta.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/v2_lora_PanLeft.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/v2_lora_PanRight.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/v2_lora_RollingAnticlockwise.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/v2_lora_RollingClockwise.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/v2_lora_TiltDown.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/v2_lora_TiltUp.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/v2_lora_ZoomIn.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/main/v2_lora_ZoomOut.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/refs%2Fpr%2F3/mm_sd_v14.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/refs%2Fpr%2F3/mm_sd_v14.safetensors'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/refs%2Fpr%2F3/mm_sd_v15.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/refs%2Fpr%2F3/mm_sd_v15.safetensors'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/refs%2Fpr%2F3/mm_sd_v15_v2.ckpt'
RUN wget --content-disposition 'https://huggingface.co/guoyww/animatediff/resolve/refs%2Fpr%2F3/mm_sd_v15_v2.safetensors'
RUN wget --content-disposition 'https://huggingface.co/manshoety/AD_Stabilized_Motion/resolve/main/mm-Stabilized_high.pth'
RUN wget --content-disposition 'https://huggingface.co/manshoety/AD_Stabilized_Motion/resolve/main/mm-Stabilized_mid.pth'
RUN wget --content-disposition 'https://huggingface.co/CiaraRowles/TemporalDiff/resolve/main/temporaldiff-v1-animatediff.ckpt'
RUN wget --content-disposition 'https://huggingface.co/CiaraRowles/TemporalDiff/resolve/main/temporaldiff-v1-animatediff.safetensors'
RUN wget --content-disposition 'https://huggingface.co/hotshotco/Hotshot-XL/resolve/main/hsxl_temporal_layers.f16.safetensors'
RUN wget --content-disposition 'https://huggingface.co/hotshotco/Hotshot-XL/resolve/main/hsxl_temporal_layers.safetensors'

RUN ls -lha

WORKDIR /home/appuser/stable-diffusion-webui

ADD webui-user.sh .

ENV IS_LOWVRAM true
ENV IS_MEDVRAM false
ENV USE_XFORMERS true
ENV USE_CUDA_118 true

RUN cat webui-user.sh

RUN python3 -m venv venv
ENV PATH="./venv/bin:$PATH"

RUN pip install --upgrade pip

#RUN pip install -U xformers --index-url https://download.pytorch.org/whl/cu118

EXPOSE 7860
ENTRYPOINT [ "./webui.sh" ]
