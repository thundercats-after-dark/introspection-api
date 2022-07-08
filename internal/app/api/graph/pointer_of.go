package graph

// PointerOf gives you back a pointer of whatever you give it
// from: https://github.com/carlmjohnson/new
func PointerOf[T any](value T) *T {
	return &value
}
