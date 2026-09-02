FROM alpine:3.23 AS build

ARG RATHENA_REF
ARG PACKETVER=20211103
ARG PACKET_OBFUSCATION_KEY1
ARG PACKET_OBFUSCATION_KEY2
ARG PACKET_OBFUSCATION_KEY3

RUN apk add --no-cache \
    cmake \
    g++ \
    gcc \
    git \
    linux-headers \
    make \
    mariadb-connector-c-dev \
    zlib-dev

WORKDIR /opt/rathena

RUN git clone https://github.com/rathena/rathena.git . \
    && git checkout "$RATHENA_REF" \
    && rm -rf .git

RUN printf '%s\n' \
    '#ifndef CONFIG_CUSTOM_DEFINES_PRE_HPP' \
    '#define CONFIG_CUSTOM_DEFINES_PRE_HPP' \
    "#define PACKETVER $PACKETVER" \
    "#define PACKET_OBFUSCATION_KEY1 $PACKET_OBFUSCATION_KEY1" \
    "#define PACKET_OBFUSCATION_KEY2 $PACKET_OBFUSCATION_KEY2" \
    "#define PACKET_OBFUSCATION_KEY3 $PACKET_OBFUSCATION_KEY3" \
    '#endif' \
    > src/custom/defines_pre.hpp

RUN ./configure --enable-packetver="$PACKETVER" \
    && make -j"$(getconf _NPROCESSORS_ONLN)" server

FROM alpine:3.23

RUN apk add --no-cache \
    gettext \
    mariadb-client \
    mariadb-connector-c

WORKDIR /opt/rathena

COPY --from=build /opt/rathena /opt/rathena
COPY entrypoint.sh /usr/local/bin/rathena-entrypoint

RUN chmod +x /usr/local/bin/rathena-entrypoint

ENTRYPOINT ["/usr/local/bin/rathena-entrypoint"]
