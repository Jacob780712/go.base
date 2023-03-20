package microsvc

import "crypto/tls"

type Cfg struct {
	opts *server
}

func New(opts ...Option) *Cfg {
	s := &server{}
	for _, srv := range opts {
		srv(s)
	}
	return &Cfg{
		opts: s,
	}
}

// SetCertFile sets the certificate file.
func SetCertFile(certFile, keyFile string) (*tls.Certificate, error) {
	cert, err := tls.LoadX509KeyPair(certFile, keyFile)
	if err != nil {
		return nil, err
	}

	return &cert, nil
}
