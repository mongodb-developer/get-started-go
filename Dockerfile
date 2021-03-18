FROM golang:alpine3.13

LABEL org.opencontainers.image.source=https://github.com/mongodb-developer/get-started-go

ENV GOPATH /home/gsuser/gopath

RUN apk add --no-cache git
RUN addgroup -S gsgroup \
    && adduser -S gsuser -G gsgroup \
    && mkdir ${GOPATH}

USER gsuser

COPY ./go/go.mod /home/gsuser/go.mod 
COPY ./go/go.sum /home/guser/go.sum
RUN cd /home/gsuser && go mod download

ENTRYPOINT ["/bin/sh", "-c"]  
