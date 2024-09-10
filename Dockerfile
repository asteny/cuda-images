FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV LANG=en_US.UTF-8

RUN apt-get update &&  \
    apt-get install -y --no-install-recommends \
      gnupg2  \
      curl  \
      ca-certificates \
      locales \
      tzdata && \
    curl -fsSLO https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    ln -snf /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales tzdata && \
    apt-get purge --autoremove -y curl &&  \
    rm -rf /var/lib/apt/lists/* /var/lib/cache/* /var/log/*

ENV LANG="en_US.UTF-8" \
	LC_CTYPE="en_US.UTF-8" \
	LC_NUMERIC="en_US.UTF-8" \
	LC_TIME="en_US.UTF-8" \
	LC_COLLATE="en_US.UTF-8" \
	LC_MONETARY="en_US.UTF-8" \
	LC_MESSAGES="en_US.UTF-8" \
	LC_PAPER="en_US.UTF-8" \
	LC_NAME="en_US.UTF-8" \
	LC_ADDRESS="en_US.UTF-8" \
	LC_TELEPHONE="en_US.UTF-8" \
	LC_MEASUREMENT="en_US.UTF-8" \
	LC_IDENTIFICATION="en_US.UTF-8"

ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

ENV NVIDIA_REQUIRE_CUDA="cuda>=12.2 brand=tesla,driver>=470,driver<471 brand=unknown,driver>=470,driver<471 brand=nvidia,driver>=470,driver<471 brand=nvidiartx,driver>=470,driver<471 brand=geforce,driver>=470,driver<471 brand=geforcertx,driver>=470,driver<471 brand=quadro,driver>=470,driver<471 brand=quadrortx,driver>=470,driver<471 brand=titan,driver>=470,driver<471 brand=titanrtx,driver>=470,driver<471 brand=tesla,driver>=525,driver<526 brand=unknown,driver>=525,driver<526 brand=nvidia,driver>=525,driver<526 brand=nvidiartx,driver>=525,driver<526 brand=geforce,driver>=525,driver<526 brand=geforcertx,driver>=525,driver<526 brand=quadro,driver>=525,driver<526 brand=quadrortx,driver>=525,driver<526 brand=titan,driver>=525,driver<526 brand=titanrtx,driver>=525,driver<526"
ENV CUDA_VERSION=12.2.2

ENV NCCL_VERSION=2.19.3-1

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf &&  \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

RUN apt-get update &&  \
    apt-get install -y --no-install-recommends \
      cuda-command-line-tools-12-2=12.2.2-1 \
      cuda-compat-12-2 \
      cuda-cudart-12-2=12.2.140-1 \
      cuda-cudart-dev-12-2=12.2.140-1 \
      cuda-libraries-12-2=12.2.2-1 \
      cuda-libraries-dev-12-2=12.2.2-1 \
      cuda-minimal-build-12-2=12.2.2-1 \
      cuda-nsight-compute-12-2=12.2.2-1 \
      cuda-nvml-dev-12-2=12.2.140-1 \
      cuda-nvprof-12-2=12.2.142-1 \
      cuda-nvtx-12-2=12.2.140-1 \
      libcublas-12-2=12.2.5.6-1 \
      libcublas-dev-12-2=12.2.5.6-1 \
      libcudnn8-dev=8.9.6.50-1+cuda12.2 \
      libcudnn8=8.9.6.50-1+cuda12.2 \
      libcusparse-12-2=12.1.2.141-1 \
      libcusparse-dev-12-2=12.1.2.141-1 \
      libnccl-dev=2.19.3-1+cuda12.2 \
      libnccl2=2.19.3-1+cuda12.2 \
      libnpp-12-2=12.2.1.4-1 \
      libnpp-dev-12-2=12.2.1.4-1 && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/cache/* /var/log/*

RUN apt-mark hold \
      libcublas-12-2 \
      libcublas-dev-12-2  \
      libnccl2  \
      libnccl-dev \
      libcudnn8

ENV LIBRARY_PATH=/usr/local/cuda/lib64/stubs
