# MarsRover

Intended to be used from the command line, will read from stdin and output to stdout ex:

`./mars_rover < input.txt`

where input.txt has input like
```
4 8
(2, 3, E) LFRFF
(0, 2, N) FFLFRFF
``` 

## Installation

Unfortunately Elixir does require Erlang to be installed to run escripts.
The escript binary has been included, but it will require that Erlang 24 is installed on the host machine.
Should that version of Erlang not be available the script can be compiled by running the following command. 

`mix escript.build` 

## Testing

The unit test can be run with following command.

`mix test`

