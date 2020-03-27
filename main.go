// go:generate
package main

import "fmt"

import (
	"context"
	"log"
	"net"
	"strconv"

	t "github.com/VictorDenisov/proto_research/examples/tutorialpb"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

type YourService struct {
}

func (y *YourService) Echo(context.Context, *t.AddressBook) (*t.AddressBook, error) {
	return nil, nil
}

func main() {
	var p t.Person

	fmt.Println("vim-go: %v", p)

	lis, err := net.Listen("tcp", ":"+strconv.Itoa(8090))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	grpcServer := grpc.NewServer()
	t.RegisterYourServiceServer(grpcServer, &YourService{})
	reflection.Register(grpcServer)
	grpcServer.Serve(lis)
}
