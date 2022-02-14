FROM golang:1.17-buster

RUN apt-get update \
    && apt-get install -y libnss3-tools

RUN curl -LO https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 \
    && chmod +x mkcert-v1.4.3-linux-amd64 \
    && mv mkcert-v1.4.3-linux-amd64 /usr/local/bin/mkcert

WORKDIR /work

RUN mkcert -install \
    && mkcert localhost 127.0.0.1 192.168.0.1

COPY go.mod .
#COPY go.sum .
COPY cmd cmd/

RUN CGO_ENABLED=0 GOOS=linux go build -v -o ./server ./cmd

CMD ["./server", "./localhost+2.pem", "./localhost+2-key.pem"]
