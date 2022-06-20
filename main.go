package main

import (
	"encoding/json"
	"fmt"
	"github.com/graphql-go/graphql"
	"log"
)

func main() {
	schema, err := graphql.NewSchema(graphql.SchemaConfig{
		Query: graphql.NewObject(graphql.ObjectConfig{
			Name: "RootQuery",
			Fields: graphql.Fields{
				"hello": &graphql.Field{
					Type: graphql.String,
					Resolve: func(p graphql.ResolveParams) (interface{}, error) {
						return "world", nil
					},
				},
			},
		}),
	})

	if err != nil {
		log.Fatalf("failed to create schema, error: %v", err)
	}

	params := graphql.Params{Schema: schema, RequestString: `{ hello }`}
	result := graphql.Do(params)
	if result.HasErrors() {
		log.Fatalf("failed to execute graphql operation, errors %+v", result.Errors)
	}
	jsonResult, _ := json.Marshal(result)
	fmt.Printf("%s \n", jsonResult)
}
