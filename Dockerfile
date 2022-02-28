FROM golang:alpine3.15

LABEL org.opencontainers.image.source=https://github.com/mongodb-developer/get-started-go

RUN apk add --no-cache git
RUN addgroup -S gsgroup && adduser -S gsuser -G gsgroup
USER gsuser

ENTRYPOINT ["/bin/sh", "-c"]  
