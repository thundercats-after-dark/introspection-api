package config

type Config struct {
	DynamoDBEndpointURL string `envconfig:"DYNAMODB_ENDPOINT_URL"`
}
