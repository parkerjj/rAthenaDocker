FROM python:3.12-slim

ARG WEBSOCKIFY_VERSION=0.13.0

RUN python -m pip install --no-cache-dir --no-deps "websockify==${WEBSOCKIFY_VERSION}" \
    && groupadd --system websockify \
    && useradd --system --gid websockify --no-create-home websockify

USER websockify

ENTRYPOINT ["websockify"]
