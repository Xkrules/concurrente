package main

import(	
	"fmt"
)

var wamtp = false
var wantq = false
func P(){
	for{
		fmt.Println("P non critical section")
		wantp = true
		for wantq{
		}
		fmt.Println("P CRITICAL section")
		want
	}
}