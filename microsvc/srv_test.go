package microsvc

import (
	"crypto/tls"
	"fmt"
	"log"
	"testing"
)

func TestCA(t *testing.T) {
	cert, err := tls.LoadX509KeyPair("../hack/certs/server.pem", "../hack/certs/server-key.pem")
	if err != nil {
		log.Println(err)
		return
	}

	config := &tls.Config{
		Certificates: []tls.Certificate{cert},
	}
	fmt.Println(string(config.Certificates[0].Certificate[0]))
}
