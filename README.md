# my-api-golang

A chance to learn some golang by writing the same app I normally do - an API
server for retrieving details about myself.


## Getting Started

This application is using Bazel because that's the build system we use at work.
I wanted to spend some time learning it, so I included it in this project. Since
we are using Bazel, you don't actually need Go installed on your computer. 
Instead, install Bazelisk (Bazel version manager) and some related dev tools:

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

To add a new dependency on a 3rd-party library, you first need to add it as a
dependency in Bazel. This is what Gazelle's `update-repos` is for. For example:

```sh
bazel run //:gazelle -- update-repos \
              -to_macro=deps.bzl%go_dependencies \
              github.com/graphql-go/graphql
```

At this point, your 3rd-party library will be available for your code to use.
Once you have a dependency established in one of your source files, run the
`//:gazelle` target to add the dependency to Bazel so your application will
compile and run correctly:

```sh
bazel run //:gazelle
```
