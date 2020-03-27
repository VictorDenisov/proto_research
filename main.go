// go:generate
package main

import "fmt"

import (
	"net"

	"example.com/examples/tutorialpb"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	var p tutorialpb.Person

	fmt.Println("vim-go: %v", p)

	lis, err := net.Listen("tcp", ":"+strconv.Itoa(applicationJson.GrpcPort))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	grpcServer := grpc.NewServer(grpc.MaxSendMsgSize(100 * MiB))
	g.RegisterGroupsServer(grpcServer, &YourService{})
	reflection.Register(grpcServer)
	go grpcServer.Serve(lis)
}
