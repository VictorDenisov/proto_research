#!/bin/bash

if [[ $# -eq 0 ]]; then
	docker run --volume=`pwd`:/home/ golang /home/generate.sh docker
else
	if [[ $1 -eq "docker" ]]; then
		echo "Running inside docker"
		cd /home/

		apt-get update
		apt-get install -y protobuf-compiler
		apt-get install -y protobuf-compiler-grpc
		apt-get install -y quilt
		go install google.golang.org/protobuf/cmd/protoc-gen-go
		go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway

		mkdir -p google/api
		pushd google/api
		wget https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto
		wget https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto

		popd

		protoc --proto_path=proto_dir --go_out=. proto_dir/sample.proto -I.
		protoc --grpc-gateway_out=logtostderr=true:. proto_dir/sample.proto

		pushd proto_dir
		quilt pop -a
		popd

		mv github.com/proto_repo/proto_dir/sample.pb.go proto_dir
		mv github.com/proto_repo/proto_dir/sample.pb.gw.go proto_dir
		rm -Rf github.com
		chown 1000:1000 proto_dir/sample.pb.go

		pushd proto_dir
		quilt push -a
		popd

		rm -Rf google


	fi
fi
