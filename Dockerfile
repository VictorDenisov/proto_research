FROM golang:1.14.0-buster

RUN apt-get update
RUN apt-get install -y protobuf-compiler
RUN apt-get install -y quilt
