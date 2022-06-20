# my-api-golang

A chance to learn some golang by writing the same app I normally do - an API
server for retrieving details about myself.

## Getting Started

```sh
brew install bazelisk buildifier buildozer
bazel build //...
```

If using IntelliJ, install the Bazel plugin. When importing the project choose
the `.bazelproject` file at the root of the repository.

### Adding a New Source File

When you add a new source file to the application you need to add it to Bazel as
well, so it is included in the build process. Gazelle will do this for you:

```sh
bazel run //:gazelle
```

### Adding a New Dependency

To add a new dependency on a 3rd-party library, add it to your go application
in the normal way. This will add the dependency to the `go.mod` file. Here's an
example of adding the graphql library:

```sh
go get github.com/graphql-go/graphql
```

Then run gazelle to generate the necessary changes to the `deps.bzl` file:

```sh
bazel run //:gazelle-update-repos
```

At this point, your 3rd-party library will be available for your code to use.
Once you have a dependency established in one of your source files, run the
`//:gazelle` target to add the dependency to Bazel so your application will
compile and run correctly:

```sh
bazel run //:gazelle
```
