FROM alpine:3.19 AS base
RUN apk add --no-cache curl ca-certificates bash

WORKDIR /
RUN mkdir -p \
  /ComfyUI/models/text_encoders \
  /ComfyUI/models/vae \
  /ComfyUI/models/diffusion_models \
  /ComfyUI/models/loras

RUN wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/allnsfw/wan22-k3nk4llinon3-15epoc-full-low-k3nk.safetensors -O /ComfyUI/models/loras/wan22-k3nk4llinon3-15epoc-full-low-k3nk.safetensors
RUN wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/allnsfw/wan22-k3nk4llinon3-16epoc-full-high-k3nk.safetensors -O /ComfyUI/models/loras/wan22-k3nk4llinon3-16epoc-full-high-k3nk.safetensors


COPY . .

COPY extra_model_paths.yaml /ComfyUI/extra_model_paths.yaml

RUN chmod +x /entrypoint.sh
#CMD ["/entrypoint.sh"]
