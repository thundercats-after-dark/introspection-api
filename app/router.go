package main

import (
	"context"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	awscfg "github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/go-chi/chi/v5"
	"github.com/thundercats-after-dark/introspection-api/app/config"
	"github.com/thundercats-after-dark/introspection-api/app/graph"
	"github.com/thundercats-after-dark/introspection-api/app/graph/generated"
)

const GraphQLEndpoint = "/graphql"

func Router(config *config.Config) (*chi.Mux, error) {
	cfg, err := awscfg.LoadDefaultConfig(context.TODO(), func(opts *awscfg.LoadOptions) error {
		opts.Region = "us-east-1"
		return nil
	})

	if err != nil {
		// todo: log error https://github.com/thundercats-after-dark/introspection-api/issues/21
		return nil, err
	}

	client := dynamodb.NewFromConfig(cfg, func(o *dynamodb.Options) {
		if config.DynamoDBEndpointURL != "" {
			o.EndpointResolver = dynamodb.EndpointResolverFromURL(config.DynamoDBEndpointURL)
		}
	})

	router := chi.NewRouter()
	router.Handle("/", playground.Handler("GraphQL playground", GraphQLEndpoint))
	router.Handle(GraphQLEndpoint, handler.NewDefaultServer(
		generated.NewExecutableSchema(generated.Config{Resolvers: &graph.Resolver{
			DynamoDBClient: client,
		}})),
	)

	return router, nil
}
