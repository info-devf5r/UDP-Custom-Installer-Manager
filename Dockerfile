#Build latest udpx from source
FROM --platform=$BUILDPLATFORM golang:1.20.4-alpine AS builder
WORKDIR /app
ARG TARGETARCH 
RUN apk --no-cache --update add build-base gcc wget curl
COPY . .
#RUN env 
RUN ./DockerInit.sh "$TARGETARCH"


#Build app image using latest udpx
FROM alpine
ENV TZ=Africa/Accra
WORKDIR /app

RUN apk add ca-certificates tzdata

#COPY --from=builder  /app/build/ /app/
VOLUME [ "/etc/udpx" ]
ENTRYPOINT [ "/app/udp" ]