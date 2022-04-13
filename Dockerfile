FROM golang

MAINTAINER derekwin seclee <jacelau@outlook.com>

ADD . /go/src/github.com/nerdalert/nflow-generator

# if chinese network, set go proxy 
RUN go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://goproxy.cn,direct

WORKDIR /etc/nflow
COPY . .
RUN go build .

RUN apt-get update \
    && apt-get install -y iperf3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Expose the default iperf3 server port
EXPOSE 5201

ENTRYPOINT ["/etc/nflow/nflow-generator","iperf3"]
