package main

import (
	"flag"
	"io"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func main() {
	port := flag.String("port", "8080", "Http port to bind api server")
	flag.Parse()

	log.Println("Starting server at port", *port)

	mux := mux.NewRouter()

	s := mux.PathPrefix("/v1/").Subrouter()
	s.HandleFunc("/", PendingImplementation)

	log.Fatal(http.ListenAndServe(":"+*port, mux))
}

// Fake route, the real route is pending implentation
func PendingImplementation(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/html")
	io.WriteString(w,
		"<center>"+
			"<img tag='gophers' src='http://talks.golang.org/2013/highperf/gopherrulespanner.png' /><br/>"+
			"This route is still under construction<br/>"+
			"Be patient little one :)</br>"+
			"</center>")
}
