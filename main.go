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
	"google.golang.org/grpc/peer"
	"google.golang.org/grpc/reflection"
)

type YourService struct {
}

func (y *YourService) Echo(c context.Context, b *t.AddressBook) (*t.AddressBook, error) {
	p, ok := peer.FromContext(c)
	fmt.Printf("%v %v\n", p, ok)

	return &t.AddressBook{
		People: []*t.Person{&t.Person{Name: "Bye"}},
	}, nil
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
