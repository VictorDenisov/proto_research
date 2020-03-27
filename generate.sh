#!/bin/bash

if [[ $# -eq 0 ]]; then
	docker run --volume=`pwd`:/home/ golang_proto /home/generate.sh docker
else
	if [[ $1 -eq "docker" ]]; then
		echo "Running inside docker"
		cd /home/

		go get -u github.com/golang/protobuf/protoc-gen-go@v1.3.5
		go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
		go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway


		mkdir -p google/api
		pushd google/api
		wget https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto
		wget https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto

		popd

		protoc --go_out=plugins=grpc:. proto_dir/sample.proto -I.
		#protoc --grpc-gateway_out=logtostderr=true:. proto_dir/sample.proto

		pushd proto_dir
		quilt pop -a
		popd

		mv github.com/proto_research/examples/tutorialpb/sample.pb.go examples/tutorialpb
		#mv github.com/proto_research/examples/tutorialpb/sample.pb.gw.go examples/tutorialpb
		rm -Rf github.com
		chown -R 1000:1000 examples

		pushd proto_dir
		quilt push -a
		popd

		rm -Rf google


	fi
fi
