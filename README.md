# file_metadata

[![Package Version](https://img.shields.io/hexpm/v/file_metadata)](https://hex.pm/packages/file_metadata)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/file_metadata/)

```sh
gleam add file_metadata@1
```

An exercise in pain! Trying to understand how to Gleam FFI into the Erlang standard library functions when you neither understand Gleam or Erlang!
I copied code from simplifile step by step and repeatedly running until I was successfully able to publish and run the Erlang read file function.
One thing I don't understand is why I don't need this line that erlang documentation is specifying should be there?
-include_lib("kernel/include/file.hrl").

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
