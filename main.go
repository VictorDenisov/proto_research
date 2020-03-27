// go:generate
package main

import "fmt"

import "example.com/examples/tutorialpb"

func main() {
	var p tutorialpb.Person
	fmt.Println("vim-go: %v", p)
}
