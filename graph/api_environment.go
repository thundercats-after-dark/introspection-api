package graph

type APIEnvironment struct {
	DynamoEndpointURL string `envconfig:"DYNAMO_ENDPOINT_URL"`
}
