# Worldspark

## Dependencies

* [LÖVE][] (0.8.x)
* [HUMP][]

## Build

First, we need the HUMP library.

```
git clone git://github.com/vrld/hump lib/hump
```

Open the sublime-project file in the project root with Sublime Text, select the "Compile LOVE2D Project" build system, and build! You will need the following depending on your platform.

### Windows

You will need the LÖVE executable and dependencies. Download and extract LÖVE ([32bit][]/[64bit][]) to `lib/love/`. You will also need to be able to run 7zip from your command line. [Run 7zip from the command line][].

### Linux 

You will need the 7zip binary to build, and the LÖVE binary to run it. On Arch Linux, you can get both with `pacman -S p7zip love08`.

### ToDo

* Update to LÖVE 0.9.x


[LÖVE]: https://love2d.org/
[HUMP]: http://vrld.github.io/hump
[32bit]: https://bitbucket.org/rude/love/downloads/love-0.8.0-win-x86.zip
[64bit]: https://bitbucket.org/rude/love/downloads/love-0.8.0-win-x64.zip
[Run 7zip from the command line]: http://stackoverflow.com/questions/14122732/unzip-files-7-zip-via-cmd-command

