#!/bin/bash

if [[ $# -eq 0 ]]; then
	docker run --volume=`pwd`:/home/ golang_proto /home/generate.sh docker
else
	if [[ $1 -eq "docker" ]]; then
		echo "Running inside docker"
		cd /home/

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

		mv github.com/proto_research/examples/tutorialpb/sample.pb.go examples/tutorialpb
		mv github.com/proto_research/examples/tutorialpb/sample.pb.gw.go examples/tutorialpb
		rm -Rf github.com
		chown -R 1000:1000 examples

		pushd proto_dir
		quilt push -a
		popd

		rm -Rf google


	fi
fi
