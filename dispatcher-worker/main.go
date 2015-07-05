package main

import (
	"log"
	"time"
)

func main() {
	for {
		log.Println("I should be a worker, but I'm currently unemployed :(")
		time.Sleep(10 * time.Second)
	}

}
