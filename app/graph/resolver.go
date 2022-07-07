package graph

//go:generate go run github.com/99designs/gqlgen generate

import (
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/thundercats-after-dark/introspection-api/app/graph/model"
)

// This file will not be regenerated automatically.
//
// It serves as dependency injection for your app, add any dependencies you require here.

type Resolver struct {
	todos          []*model.Todo
	DynamoDBClient *dynamodb.Client
}
