load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_dependencies():
    go_repository(
        name = "com_github_graphql_go_graphql",
        importpath = "github.com/graphql-go/graphql",
        sum = "h1:JHRQMeQjofwqVvGwYnr8JnPTY0AxgVy1HpHSGPLdH0I=",
        version = "v0.8.0",
    )
