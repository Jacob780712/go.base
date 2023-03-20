package microsvc

import (
	"crypto/tls"
	"fmt"
	gw "github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
	"log"
	"net"
	"net/http"
	"strings"
	"sync"
)

type server struct {
	ctx   context.Context
	mutex sync.RWMutex
	wg    sync.WaitGroup
	tcfg  *tls.Config

	addr string

	grpc      *grpc.Server
	http      *http.Server
	ServerMux *gw.ServeMux

	Err error
}

func grpcHandlerFunc(grpcServer *grpc.Server, muxgw http.Handler) http.Handler {
	if muxgw == nil {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			grpcServer.ServeHTTP(w, r)
		})
	}
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.ProtoMajor == 2 && strings.Contains(r.Header.Get("Content-Type"), "application/grpc") {
			grpcServer.ServeHTTP(w, r)
			fmt.Println("GRPC")
		} else {
			muxgw.ServeHTTP(w, r)
			fmt.Println("REST")
		}
	})
}

func (c *Cfg) Server() *server {

	if c.opts.addr == "" {
		l, err := net.Listen("tcp", ":0")
		if err != nil {
			log.Fatalf("failed to listen: %v", err)
		}
		c.opts.addr = l.Addr().String()
	}
	return &server{
		ctx:       context.Background(),
		tcfg:      c.opts.tcfg,
		addr:      c.opts.addr,
		grpc:      grpc.NewServer(),
		ServerMux: gw.NewServeMux(),
	}
}

func (s *server) Run() error {
	s.http = &http.Server{
		Addr:      s.addr,
		Handler:   grpcHandlerFunc(s.grpc, s.ServerMux),
		TLSConfig: s.tcfg,
	}

	log.Printf("Starting listening on port: %s", s.addr)
	if err := s.http.ListenAndServeTLS("", ""); err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	return nil
}
