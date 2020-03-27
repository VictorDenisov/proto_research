module github.com/VictorDenisov/go_proto

go 1.12

require (
	example.com/examples v0.0.0
	github.com/golang/protobuf v1.4.0-rc.4
	github.com/grpc-ecosystem/grpc-gateway v1.14.3 // indirect
	google.golang.org/protobuf v1.20.1
)

replace example.com/examples => ./dst/example.com/examples
