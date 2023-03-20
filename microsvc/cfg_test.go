package microsvc

import (
	"testing"
)

func TestNew(t *testing.T) {
	n := New(WithAddress("7890"))
	t.Log(n.opts.addr)
}
