# Installation guide

## System and Hardware Requirements
1. x86_64/amd64 architecture
1. Ubuntu 22.04 Server Installed.
1. Nvidia Graphics Card (tested on 1060 6GB VRam).

## Prerequisites
1. Install Docker on your host machine: https://docs.docker.com/engine/install/ubuntu/.
1. Install CUDA and Nvidia drivers on your host machine: https://www.cherryservers.com/blog/install-cuda-ubuntu.
   1. Tested and optimized for CUDA 11.8.
   1. Tested with Nvidia Drivers version 545.
1. Clone this repository.

## Installation

### AUTOMATIC1111
https://github.com/AUTOMATIC1111/stable-diffusion-webui

1. Run `docker compose build automatic1111.v1.6`.
1. Run `docker compose up automatic1111 -d`.

Automatic1111 should be available: http://127.0.0.1:7860, docker will limit RAM usage to 8GB.

Build and run take a while... depending on your network speed, at the end you will have:
- Docker Image created.
- Docker container running with dedicated volume.
- Automatic1111 installed to the dedicated volume and accesible from your network.

Pre-installed models:
1. epiCPhotoGasm: Last Unicorn
2. Realistic Vision V6.0 B1: 6.0 B1 (VAE)
3. RunDiffusionXL: beta
4. Juggernaut XL: V7 + RunDiffusion
5. RealLife: v3.0

Pre-installed plugins:
1. deforum-for-automatic1111-webui
2. sd-webui-additional-networks
3. sd-webui-controlnet -> with models from https://github.com/Mikubill/sd-webui-controlnet/discussions/2039
4. sd-civitai-browser-plus
5. sd-webui-animatediff -> with models from https://github.com/continue-revolution/sd-webui-animatediff#model-zoo
6. posex
7. stable-diffusion-webui-images-browser

#### Customization

##### Environment settings
You can customize your container by setting the following env variables:
- IS_LOWVRAM=true/false -> if set to true IS_MEDVRAM will be ignored, adds: --lowvram --opt-split-attention
- IS_MEDVRAM=true/false -> adds: --medvram
- USE_XFORMERS=true/false -> adds: --xformers
- USE_CUDA_118=true/false -> installs torch optimized for CUDA 11.8

Default ENV settings:
- IS_LOWVRAM=true
- IS_MEDVRAM=false
- USE_XFORMERS=true
- USE_CUDA_118=true

##### Memory settings
Default memory limit is set to 8 GB. If you want to change it you can manipulate on mem_reservation and mem_limit options from docker-compose.yml.

### FaceFusion
https://github.com/facefusion/facefusion

1. Run `docker compose build facefusion.v2`.
1. Run `docker compose up facefusion -d`.

FaceFusion 2.X should be available: http://127.0.0.1:7862, docker will limit RAM usage to 8GB.

#### Customization

##### Memory settings
Default memory limit is set to 8 GB. If you want to change it you can manipulate on mem_reservation and mem_limit options from docker-compose.yml.

### Kohya_SS - IN PROGRESS.
https://github.com/bmaltais/kohya_ss

## Usefull links
- https://github.com/AUTOMATIC1111/stable-diffusion-webui
- https://github.com/facefusion/facefusion
- https://github.com/bmaltais/kohya_ss
- https://www.cherryservers.com/blog/install-cuda-ubuntu
- https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/11.7.1/ubuntu2204/base/Dockerfile
- https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html#package-manager-ubuntu-install
- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
- https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_network
