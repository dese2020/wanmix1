#BASE
FROM wlsdml1114/engui_base_128_blackwell_13:1.2 AS runtime

RUN pip install -U "huggingface_hub[hf_transfer]"
RUN pip install runpod websocket-client

WORKDIR /


# Antes de clonar, ajusta git
RUN git config --global http.version HTTP/1.1 \
 && git config --global http.lowSpeedLimit 1 \
 && git config --global http.lowSpeedTime 600 \
 && git config --global http.postBuffer 524288000 \
 \
 && git clone --depth=1 https://github.com/comfyanonymous/ComfyUI.git /ComfyUI \
 \
 && pip install --no-cache-dir -r /ComfyUI/requirements.txt \
 \
 && mkdir -p /ComfyUI/custom_nodes \
 \
 && git clone --depth=1 https://github.com/kijai/ComfyUI-KJNodes /ComfyUI/custom_nodes/ComfyUI-KJNodes \
 && pip install --no-cache-dir -r /ComfyUI/custom_nodes/ComfyUI-KJNodes/requirements.txt \
 \
 && git clone --depth=1 https://github.com/Fannovel16/ComfyUI-Frame-Interpolation /ComfyUI/custom_nodes/ComfyUI-Frame-Interpolation \
 && python /ComfyUI/custom_nodes/ComfyUI-Frame-Interpolation/install.py \
 \
 && git clone --depth=1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite /ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite \
 && pip install --no-cache-dir -r /ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite/requirements.txt \
 \
 && git clone --depth=1 https://github.com/yolain/ComfyUI-Easy-Use /ComfyUI/custom_nodes/ComfyUI-Easy-Use \
 && pip install --no-cache-dir -r /ComfyUI/custom_nodes/ComfyUI-Easy-Use/requirements.txt \
 \
 && git clone --depth=1 https://github.com/city96/ComfyUI-GGUF /ComfyUI/custom_nodes/ComfyUI-GGUF \
 && pip install --no-cache-dir -r /ComfyUI/custom_nodes/ComfyUI-GGUF/requirements.txt \
 \
 && git clone --depth=1 https://github.com/wallen0322/ComfyUI-Wan22FMLF /ComfyUI/custom_nodes/ComfyUI-Wan22FMLF \
 \
 && git clone --depth=1 https://github.com/cubiq/ComfyUI_essentials /ComfyUI/custom_nodes/ComfyUI_essentials \
 && pip install --no-cache-dir -r /ComfyUI/custom_nodes/ComfyUI_essentials/requirements.txt \
 \
 && git clone --depth=1 https://github.com/M1kep/ComfyLiterals /ComfyUI/custom_nodes/ComfyLiterals \
 \
 && find /ComfyUI -name ".git" -type d -exec rm -rf {} + 
	
#bassets
RUN wget -q https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/LoRAs/Stable-Video-Infinity/v2.0/SVI_v2_PRO_Wan2.2-I2V-A14B_HIGH_lora_rank_128_fp16.safetensors -O /ComfyUI/models/loras/SVI_v2_PRO_Wan2.2-I2V-A14B_HIGH_lora_rank_128_fp16.safetensors && \
	wget -q https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/LoRAs/Stable-Video-Infinity/v2.0/SVI_v2_PRO_Wan2.2-I2V-A14B_LOW_lora_rank_128_fp16.safetensors -O /ComfyUI/models/loras/SVI_v2_PRO_Wan2.2-I2V-A14B_LOW_lora_rank_128_fp16.safetensors && \
	wget -q https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors -O /ComfyUI/models/vae/wan_2.1_vae.safetensors && \
	wget -q https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q8_0.gguf -O /ComfyUI/models/text_encoders/umt5-xxl-encoder-Q8_0.gguf
	
RUN wget -q https://huggingface.co/BigDannyPt/Wan-2.2-Remix-GGUF/resolve/main/I2V/v3.0/High/wan22RemixT2VI2V_i2vHighV30-Q8_0.gguf -O /ComfyUI/models/diffusion_models/wan22RemixT2VI2V_i2vHighV30-Q8_0.gguf && \
	wget -q https://huggingface.co/BigDannyPt/Wan-2.2-Remix-GGUF/resolve/main/I2V/v3.0/Low/wan22RemixT2VI2V_i2vLowV30-Q8_0.gguf -O /ComfyUI/models/diffusion_models/wan22RemixT2VI2V_i2vLowV30-Q8_0.gguf 
	
RUN wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/multi_nude/W22_Multiscene_Photoshoot_Softcore_i2v_HN.safetensors -O /ComfyUI/models/loras/W22_Multiscene_Photoshoot_Softcore_i2v_HN.safetensors && \                 
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/multi_nude/W22_Multiscene_Photoshoot_Softcore_i2v_LN.safetensors -O /ComfyUI/models/loras/W22_Multiscene_Photoshoot_Softcore_i2v_LN.safetensors && \                  
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/kiss/WAN2.2-FrenchKiss_HighNoise.safetensors -O /ComfyUI/models/loras/WAN2.2-FrenchKiss_HighNoise.safetensors                                   && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/kiss/WAN2.2-FrenchKiss_LowNoise.safetensors -O /ComfyUI/models/loras/WAN2.2-FrenchKiss_LowNoise.safetensors                                     && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/missionary/W22_HN_i2v_POV_Missionary_Insertion_v1.safetensors -O /ComfyUI/models/loras/W22_HN_i2v_POV_Missionary_Insertion_v1.safetensors       && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/missionary/W22_LN_i2v_POV_Missionary_Insertion_v1.safetensors -O /ComfyUI/models/loras/W22_LN_i2v_POV_Missionary_Insertion_v1.safetensors       && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/pov_ride/W22_POV_Cowgirl_Insertion_i2v_HN_v1A.safetensors -O /ComfyUI/models/loras/W22_POV_Cowgirl_Insertion_i2v_HN_v1A.safetensors             && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/pov_ride/W22_POV_Cowgirl_Insertion_i2v_HN_v1B.safetensors -O /ComfyUI/models/loras/W22_POV_Cowgirl_Insertion_i2v_HN_v1B.safetensors             && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/pov_ride/W22_POV_Cowgirl_Insertion_i2v_LN_v1.safetensors -O /ComfyUI/models/loras/W22_POV_Cowgirl_Insertion_i2v_LN_v1.safetensors               && \
	wget -q https://huggingface.co/hijdese2020/coopbj/resolve/main/WAN-2.2-I2V-Double-Blowjob-HIGH-v1.safetensors -O /ComfyUI/models/loras/WAN-2.2-I2V-Double-Blowjob-HIGH-v1.safetensors                                           && \
	wget -q https://huggingface.co/hijdese2020/coopbj/resolve/main/WAN-2.2-I2V-Double-Blowjob-LOW-v1.safetensors -O /ComfyUI/models/loras/WAN-2.2-I2V-Double-Blowjob-LOW-v1.safetensors                                             && \
	wget -q https://huggingface.co/hijdese2020/ultimate_deep/resolve/main/wan22-ultimatedeepthroat-I2V-34epoc-high-k3nk.safetensors -O /ComfyUI/models/loras/wan22-ultimatedeepthroat-I2V-34epoc-high-k3nk.safetensors              && \
	wget -q https://huggingface.co/hijdese2020/ultimate_deep/resolve/main/wan22-ultimatedeepthroat-I2V-101epoc-low-k3nk.safetensors -O /ComfyUI/models/loras/wan22-ultimatedeepthroat-I2V-101epoc-low-k3nk.safetensors              && \
	wget -q https://huggingface.co/hijdese2020/facialsplash/resolve/main/wan22-f4c3spl4sh-100epoc-high-k3nk.safetensors -O /ComfyUI/models/loras/wan22-f4c3spl4sh-100epoc-high-k3nk.safetensors                                     && \
	wget -q https://huggingface.co/hijdese2020/facialsplash/resolve/main/wan22-f4c3spl4sh-154epoc-low-k3nk.safetensors  -O /ComfyUI/models/loras/wan22-f4c3spl4sh-154epoc-low-k3nk.safetensors                                      && \
	wget -q https://huggingface.co/hijdese2020/oral_insert/resolve/main/wan2.2-i2v-high-oral-insertion-v1.0.safetensors -O /ComfyUI/models/loras/wan2.2-i2v-high-oral-insertion-v1.0.safetensors                                    && \
	wget -q https://huggingface.co/hijdese2020/oral_insert/resolve/main/wan2.2-i2v-low-oral-insertion-v1.0.safetensors  -O /ComfyUI/models/loras/wan2.2-i2v-low-oral-insertion-v1.0.safetensors                                     && \
	wget -q https://huggingface.co/hijdese2020/nude/resolve/main/W22_NSFW_Posing_Nude_i2v_HN_v1.safetensors -O /ComfyUI/models/loras/W22_NSFW_Posing_Nude_i2v_HN_v1.safetensors                                                     && \
	wget -q https://huggingface.co/hijdese2020/nude/resolve/main/W22_NSFW_Posing_Nude_i2v_LN_v1.safetensors -O /ComfyUI/models/loras/W22_NSFW_Posing_Nude_i2v_LN_v1.safetensors   
RUN wget -q https://huggingface.co/hijdese2020/breast_insert/resolve/main/wan2.2-i2v-high-breast-insertion-v1.0.safetensors  -O /ComfyUI/models/loras/wan2.2-i2v-high-breast-insertion-v1.0.safetensors                             && \
	wget -q https://huggingface.co/hijdese2020/breast_insert/resolve/main/wan2.2-i2v-low-breast-insertion-v1.0.safetensors -O /ComfyUI/models/loras/wan2.2-i2v-low-breast-insertion-v1.0.safetensors                                && \
	wget -q https://huggingface.co/hijdese2020/sex_fov/resolve/main/wan2.2-i2v-high-sex-fov-slider-v1.0.safetensors -O /ComfyUI/models/loras/wan2.2-i2v-high-sex-fov-slider-v1.0.safetensors                                        && \
	wget -q https://huggingface.co/hijdese2020/sex_fov/resolve/main/wan2.2-i2v-low-sex-fov-slider-v1.0.safetensors -O /ComfyUI/models/loras/wan2.2-i2v-low-sex-fov-slider-v1.0.safetensors                                          && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_tit/iGoon_Blink_Titjob_I2V_HIGH.safetensors -O /ComfyUI/models/loras/iGoon_Blink_Titjob_I2V_HIGH.safetensors                              && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_tit/iGoon_Blink_Titjob_I2V_LOW.safetensors  -O /ComfyUI/models/loras/iGoon_Blink_Titjob_I2V_LOW.safetensors                               && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_hand/iGoon_Blink_Handjob_I2V_HIGH.safetensors -O /ComfyUI/models/loras/iGoon_Blink_Handjob_I2V_HIGH.safetensors                           && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_hand/iGoon_Blink_Handjob_I2V_LOW.safetensors  -O /ComfyUI/models/loras/iGoon_Blink_Handjob_I2V_LOW.safetensors                            && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_blow/iGOON_Blink_Blowjob_I2V_HIGH.safetensors -O /ComfyUI/models/loras/iGOON_Blink_Blowjob_I2V_HIGH.safetensors                           && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_blow/iGOON_Blink_Blowjob_I2V_LOW.safetensors  -O /ComfyUI/models/loras/iGOON_Blink_Blowjob_I2V_LOW.safetensors                            && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_cum/iGoon_Blink_Facial_I2V_HIGH.safetensors -O /ComfyUI/models/loras/iGoon_Blink_Facial_I2V_HIGH.safetensors                              && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_cum/iGoon_Blink_Facial_I2V_LOW.safetensors  -O /ComfyUI/models/loras/iGoon_Blink_Facial_I2V_LOW.safetensors                               && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/allnsfw/wan22-k3nk4llinon3-15epoc-full-low-k3nk.safetensors -O /ComfyUI/models/loras/wan22-k3nk4llinon3-15epoc-full-low-k3nk.safetensors        && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/allnsfw/wan22-k3nk4llinon3-16epoc-full-high-k3nk.safetensors -O /ComfyUI/models/loras/wan22-k3nk4llinon3-16epoc-full-high-k3nk.safetensors      && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_ride/Blink_Squatting_Cowgirl_Position_I2V_HIGH.safetensors -O /ComfyUI/models/loras/Blink_Squatting_Cowgirl_Position_I2V_HIGH.safetensors && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_ride/Blink_Squatting_Cowgirl_Position_I2V_LOW.safetensors  -O /ComfyUI/models/loras/Blink_Squatting_Cowgirl_Position_I2V_LOW.safetensors  && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_doggy/iGoon-Blink_Front_Doggystyle_I2V_HIGH.safetensors    -O /ComfyUI/models/loras/iGoon-Blink_Front_Doggystyle_I2V_HIGH.safetensors     && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_doggy/iGoon-Blink_Front_Doggystyle_I2V_LOW.safetensors     -O /ComfyUI/models/loras/iGoon-Blink_Front_Doggystyle_I2V_LOW.safetensors      && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_fuck/iGoon-Blink_Missionary_I2V_LOW_v2.safetensors         -O /ComfyUI/models/loras/iGoon-Blink_Missionary_I2V_LOW_v2.safetensors         && \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/blink_fuck/iGoon_Blink_Missionary_I2V_HIGH_v2.safetensors        -O /ComfyUI/models/loras/iGoon_Blink_Missionary_I2V_HIGH_v2.safetensors	&& \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/multiblow/W22_Multiscene_BJ_i2v_HN.safetensors -O /ComfyUI/models/loras/W22_Multiscene_BJ_i2v_HN.safetensors	&& \
	wget -q https://huggingface.co/datasets/hijdese2020/wan22_datalora/resolve/main/multiblow/W22_Multiscene_BJ_i2v_LN.safetensors -O /ComfyUI/models/loras/W22_Multiscene_BJ_i2v_LN.safetensors

# Download models qwen
RUN wget -q https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/resolve/main/v23/Qwen-Rapid-AIO-NSFW-v23.safetensors -O /ComfyUI/models/diffusion_models/Qwen-Rapid-AIO-NSFW-v23.safetensors && \
	wget -q https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors -O /ComfyUI/models/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors && \
	wget -q https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors -O /ComfyUI/models/vae/qwen_image_vae.safetensors


COPY . .
RUN mkdir -p /ComfyUI/user/default/ComfyUI-Manager
COPY config.ini /ComfyUI/user/default/ComfyUI-Manager/config.ini
COPY extra_model_paths.yaml /ComfyUI/extra_model_paths.yaml
COPY rife49.pth /ComfyUI/custom_nodes/ComfyUI-Frame-Interpolation/ckpts/rife/rife49.pth
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
