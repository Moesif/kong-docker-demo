FROM kong:latest
USER root
RUN apt-get update && apt-get install -y \
    gcc \
    zlib1g-dev \
    make \
    unzip \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Manually download and install lua-zlib
RUN wget https://luarocks.org/manifests/brimworks/lua-zlib-1.2-0.rockspec && \
    luarocks install lua-zlib-1.2-0.rockspec

RUN luarocks install --server=http://luarocks.org/manifests/moesif kong-plugin-moesif
USER kong
