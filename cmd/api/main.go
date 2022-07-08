package main

import (
	"log"
	"net/http"

	"github.com/kelseyhightower/envconfig"
	"github.com/thundercats-after-dark/introspection-api/internal/app/api"
	"github.com/thundercats-after-dark/introspection-api/internal/app/api/config"
)

const defaultPort = "8080"

func main() {
	var cfg config.Config
	envconfig.MustProcess("", &cfg)

	router, err := api.Router(&cfg)
	if err != nil {
		log.Fatalf("Failed to build router: %v", err)
	}

	log.Printf("config is %#v", cfg)
	log.Printf("connect to http://localhost:%s/ for GraphQL playground", defaultPort)
	log.Fatal(http.ListenAndServe(":"+defaultPort, router))
}
