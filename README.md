# resolveFinderAlias

A small command line utility for the Mac that outputs the file paths encoded by
Finder aliases.

To use `resolveFinderAlias`, invoke it at the command line with one or more file paths as in:
```sh
resolveFinderAlias file...
```
For each provided file path, if the path represents a Finder alias,
`resolveFinderAlias` will output the file path encoded by the alias;
otherwise it outputs the full path for the provided path.

You can compile `resolveFinderAlias` with Clang using the following command:
```sh
clang -framework Foundation main.m -o resolveFinderAlias
```
