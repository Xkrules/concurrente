package main

import (
	"fmt"
	"time"
)

func msg(str string) {
	fmt.Println(str)
}

var turn = 1

func p() {
	for {
		msg("P: non critical section 1")
		msg("P: non critical section 2")
		msg("P: non critical section 3")
		for turn != 1 {

		}
		msg("P: critical section 1")
		msg("P: critical section 2")
		msg("P: critical section 3")
		turn = 2
	}
}

func q() {
	for {
		msg("Q: non critical section 1")
		msg("Q: non critical section 2")
		msg("Q: non critical section 3")
		for turn != 2 {

		}
		msg("Q: critical section 1")
		msg("Q: critical section 2")
		msg("Q: critical section 3")
		turn = 1
	}
}

func main() {
	go p()
	go q()
	time.Sleep(100 * time.Millisecond)
}
