ARG NODE_IMAGE
FROM node:${NODE_IMAGE} AS builder
RUN apk add \
    git \
    make
RUN mkdir /workdir
WORKDIR /workdir
ENTRYPOINT ["/bin/sh", "-c"]

FROM node:${NODE_IMAGE} as platform
ARG TARGETPLATFORM
COPY dist /dist
RUN if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then cp /dist/exposr-*-linux-x64 /exposr; fi
RUN if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then cp /dist/exposr-*-linux-arm64 /exposr; fi
RUN if [ "${TARGETPLATFORM}" = "linux/arm/v7" ]; then cp /dist/exposr-*-linux-armv7 /exposr; fi

FROM scratch
COPY --from=platform /exposr /exposr
ENTRYPOINT ["/exposr"]