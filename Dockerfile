FROM golang

RUN apt-get update
RUN apt-get install -y protobuf-compiler
RUN apt-get install -y protobuf-compiler-grpc
RUN apt-get install -y quilt
RUN go get google.golang.org/protobuf/cmd/protoc-gen-go
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go
RUN go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
RUN go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
