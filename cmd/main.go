package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World")
}

func main() {

	if len(os.Args) < 2 {
		log.Fatal("crt and key must be set")
	}

	crt, key := os.Args[1], os.Args[2]

	cat(crt)
	cat(key)

	http.HandleFunc("/", handler)
	err := http.ListenAndServeTLS(":8080", crt, key, nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}


func cat(filename string)  {
	file, err := os.Open(filename)
	defer file.Close()

	data, err := ioutil.ReadAll(file)

	if err != nil {
		log.Panicln(err)
	}

	fmt.Println("==", filename, "==")
	fmt.Println(string(data))
}