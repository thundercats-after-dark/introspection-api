# introspection-api

A chance to learn some golang by writing the same app I normally do - an API
server for retrieving details about myself.

This project is a Golang API built using [gqlgen](https://gqlgen.com). It stores
its state in an Amazon DynamoDB table. Running locally leverages
the [Dynamodb-Local](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html)
project.

You can view the deployed application
at [https://introspect.cloud.thundercats.dev/](https://introspect.cloud.thundercats.dev/)
.

## Local Development

### Initial Setup

Install:

- Docker (on Mac you'd use Docker Desktop)
- tfswitch

### Running Locally

```sh
docker-compose up dynamodb
cd infrastructure/components/local
tfswitch
terraform init
terraform apply # adds the necessary table to your local dynamodb
docker-compose up # load up the app
```

### Adding a New Graph Node

1. Update [internal/app/api/graph/schema.graphqls](internal/app/api/graph/schema.graphqls)
   with your new graph node
2. Run `go generate ./...` to generate supporting code (models, stub resolvers,
   etc)
3. Populate the generated resolver with the implementation

## Deploying changes

Changes to the application are deployed automatically using the "AWS App Runner"
GitHub Actions Workflow when merged to the main branch.

## Running Terraform

To run Terraform against production, you'll need access to the "Thundercats
After Dark" AWS Account. Reach out to one of the organization members for
access. Once added, generate yourself some access keys, activate your profile,
and:

```sh
cd infrastructure/components/prod
tfswitch
terraform init
terraform apply
```
