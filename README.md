# Installation guide

## System and Hardware Requirements
1. x86_64 architecture
1. Ubuntu 22.04 Server Installed.
1. Nvidia Graphics Card (tested on 1060 6GB VRam).

## Prerequisites
1. Install Docker on your host machine: https://docs.docker.com/engine/install/ubuntu/.
1. Install CUDA and Nvidia drivers on your host machine: https://www.cherryservers.com/blog/install-cuda-ubuntu.
   1. Tested and optimized for CUDA 12.2.
   1. Tested with Nvidia Drivers version 535 and 545.
1. Clone this repository.

## Installation

### AUTOMATIC1111
https://github.com/AUTOMATIC1111/stable-diffusion-webui

1. Run `docker compose build automatic1111`.
1. Run `docker compose up automatic1111 -d`.

Automatic1111 should be available: http://127.0.0.1:7860

Build and run take a while... depending on your network speed, at the end you will have:
- Docker Image created.
- Docker container running with dedicated volume.
- Automatic1111 installed to the dedicated volume and accesible from your network.

#### Customization
You can customize your container by setting the following env variables:
- USE_CUDA_121=true/false -> provides CUDA support, basically it configures the right torch and torchvision versions to be installed
- IS_MACOS=true/false ->
- USE_XFORMERS=true/false -> adds --xformers to the AUTOMATIC1111 run path,

### Kohya_SS
https://github.com/bmaltais/kohya_ss

1. Run `docker compose build kohya_ss`.
1. Run `docker compose up kohya_ss -d`.

### FaceFusion
https://github.com/facefusion/facefusion

1. Run `docker compose build facefusion`.
1. Run `docker compose up facefusion -d`.

## Usefull links
- https://github.com/AUTOMATIC1111/stable-diffusion-webui
- https://github.com/facefusion/facefusion
- https://github.com/bmaltais/kohya_ss
- https://www.cherryservers.com/blog/install-cuda-ubuntu
- https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/11.7.1/ubuntu2204/base/Dockerfile
- https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html#package-manager-ubuntu-install
- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
- https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_network
