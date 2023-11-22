package server

import (
	"fmt"
	"net/http"
)

const GET_REQUEST = "GET"
const POST_REUQEST = "POST"

func HandleGQL(w http.ResponseWriter, req *http.Request) {
	for name, headers := range req.Header {
		for _, h := range headers {
			fmt.Fprintf(w, "%v: %v\n", name, h)
		}
	}
}
