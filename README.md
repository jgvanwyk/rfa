# rfa

A small command line utility for the Mac that resolves Finder aliases.

To use `rfa`, invoke it at the command line with one or more file paths:
```sh
rfa file...
```
For each provided file path, if the path represents a Finder alias,
`rfa` will output the file path encoded by the alias;
otherwise it outputs the full path for the provided path.

You can compile `rfa` with Clang using the following command:
```sh
clang -framework CoreFoundation main.m -o rfa
```
