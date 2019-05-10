package main

import "fmt"

type Loud interface {
	beLoud(str string) string
}

func highlight(loud Loud, msg string) {
	fmt.Println(loud.beLoud(msg))
}

type Dog struct {
	name string
}

type Singer struct {
	bandName string
}

func (dog Dog)beLoud(str string) string {
	return fmt.Sprintf("%s: GUAU GUAU GUAU(%s)", dog.name, str)
}

func (singer Singer)beLoud(str string) string {
	return fmt.Sprintf("%s: %s🎶🎶🎵🎵", singer.bandName, str)
}

func main() {
	fido := Dog{"Fido"}
	kurt := Singer{"Nirvana"}

	highlight(fido, "Primer mensaje")
	highlight(kurt, "Segundo mensaje")
}