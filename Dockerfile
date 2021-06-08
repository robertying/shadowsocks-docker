FROM alpine:latest

WORKDIR /app

RUN adduser -S ssuser

RUN export V2RAY_PLUGIN_VERSION=1.3.1 \
    && wget "https://github.com/shadowsocks/v2ray-plugin/releases/download/v$V2RAY_PLUGIN_VERSION/v2ray-plugin-linux-amd64-v$V2RAY_PLUGIN_VERSION.tar.gz" \
    && tar xf "v2ray-plugin-linux-amd64-v$V2RAY_PLUGIN_VERSION.tar.gz" \
    && mv v2ray-plugin_linux_amd64 v2ray-plugin

RUN export SHADOWSOCKS_VERSION=1.11.1 \
    && wget "https://github.com/shadowsocks/shadowsocks-rust/releases/download/v$SHADOWSOCKS_VERSION/shadowsocks-v$SHADOWSOCKS_VERSION.x86_64-unknown-linux-musl.tar.xz" \
    && tar xf "shadowsocks-v$SHADOWSOCKS_VERSION.x86_64-unknown-linux-musl.tar.xz"

ENV PATH="/app/custom:/app:${PATH}"

USER ssuser

CMD ["ssserver", "-c", "custom/config.json"]
