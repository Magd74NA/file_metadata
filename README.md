# file_metadata

[![Package Version](https://img.shields.io/hexpm/v/file_metadata)](https://hex.pm/packages/file_metadata)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/file_metadata/)

An exercise in pain! This started when I was trying to make a small practice project cli tool using file API.
I had tried out simplifile in another project so I wanted to try file streams instead. I imported the filestream library.
I then realized the filestream library had no file metadata reading function so I decided like an idiot I'd try to learn Erlang FFI since erlang had a file metadata function to read file metadata from the OS. Then I tried really hard to understand how the hell you would call the read_file_info(File, Opts) function. Then I tried looking at the gleam/erlang package for an example on writing FFI's to erlang. Then I realized simplifile had this FFI already written so I copied that. Then I realized the file_stream library comes packaged with simplifile and then I felt truly stupid.
Trying to understand how to Gleam FFI into the Erlang standard library functions when you neither understand Gleam or Erlang!
I copied code from simplifile step by step and repeatedly running until I was successfully able to publish and run the Erlang read file function.
One thing I don't understand is why I don't need this line that erlang documentation is specifying should be there?
-include_lib("kernel/include/file.hrl").

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
