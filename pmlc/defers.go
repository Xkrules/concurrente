package main

import "fmt"

func hacerAlgo(str string) {
	defer fmt.Printf("Defer 1(%s)\n", str)
	defer fmt.Printf("Defer 2(%s)\n", str)
	defer fmt.Printf("Defer 3(%s)\n", str)

	fmt.Printf("haciendo algo...(%s)\n", str)
}

func main() {
	defer hacerAlgo("Algo en diferido!")
	hacerAlgo("Primer hacer algo!")
}