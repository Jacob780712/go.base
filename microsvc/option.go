package microsvc

import (
	"crypto/tls"
)

type Option func(o *server)

func WithAddress(addr string) Option {
	return func(s *server) {
		s.addr = addr
	}
}

func WithTLSConfig(cfg *tls.Config) Option {
	return func(s *server) {
		s.tcfg = cfg
	}
}
