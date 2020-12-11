FROM ubuntu:20.04

ARG DRIVER_VERSION=1.4.4
ARG MONGODB_URI

RUN apt-get update && apt-get install -y \
    nano \
    vim \
    sudo \
    git \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/ubuntu && \
    echo "ubuntu:x:${uid}:${gid}:Developer,,,:/home/ubuntu:/bin/bash" >> /etc/passwd && \
    echo "ubuntu:x:${uid}:" >> /etc/group && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    chown ${uid}:${gid} -R /home/ubuntu

ENV HOME /home/ubuntu
ENV GOROOT "/usr/local/go"
ENV GOPATH ${HOME}
ENV PATH "$PATH:$GOPATH/bin:$GOROOT/bin"

WORKDIR ${HOME}

RUN wget --quiet https://dl.google.com/go/go1.15.3.linux-amd64.tar.gz \
&& tar -xf go1.15.3.linux-amd64.tar.gz \
&& mv go /usr/local

ENV DRIVER_VERSION ${DRIVER_VERSION}
ENV MONGODB_URI ${MONGODB_URI}

RUN mkdir -p ${HOME}/go && mkdir /workspace
COPY ./go/getstarted.go ${HOME}/go/getstarted.go
COPY ./go/go.mod ${HOME}/go/go.mod

RUN sed -i "s/x.x.x/${DRIVER_VERSION}/g" ${HOME}/go/go.mod

RUN chown -R ubuntu ${HOME} && chmod -R 750 ${HOME}

USER ubuntu

WORKDIR ${HOME}/go

CMD ["/bin/bash"]  
