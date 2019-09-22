package api

import (
	"fmt"
	"net/http"
)

// EchoHandleFunc to be used as http.HandleFunc for ECHO API
func EchoHandleFunc(w http.ResponseWriter, r *http.Request) {
	message := r.URL.Query()["message"]
	w.Header().Add("Content-Type", "text/plain; charset=utf-8")

	if len(message) == 0 {
		fmt.Fprintf(w, "Nothing to echo - Please provide a message")
		return
	}

	fmt.Fprintln(w, message[0])
}
