FROM nvidia/cuda:11.3.0-cudnn8-runtime-ubuntu20.04

RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends libgl1 libglib2.0-0 git wget curl vim python3 python3-venv && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
WORKDIR /stable-diffusion-webui/

RUN ./webui.sh -f can_run_as_root --exit --skip-torch-cuda-test

ENV VIRTUAL_ENV=/stable-diffusion-webui/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

CMD ["python3", "launch.py", "--listen --skip-torch-cuda-test --no-half"]
