FROM kong:latest
USER root
RUN apt-get update && apt-get install -y \
    gcc \
    zlib1g-dev \
    make \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN luarocks install --server=http://luarocks.org/manifests/moesif kong-plugin-moesif
USER kong
