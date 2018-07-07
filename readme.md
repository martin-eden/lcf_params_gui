Generate command-line call text according selected widgets.

# Description

Yo dawg I herd you like GUIs so we provided GUI to generate
command-line text in your GUI.

It generates Bash text to call [Lua code formatter](lcf) to reformat
given file with selected parameters. You still have to add name of file
at the end of generated text by yourself.

This is experimental project. Intention is to ease start of usage
command-line tool. And display all possible options and their relations
on one screen.


# Licenses

TekUI - MIT,
@this - GPLv3


# Requirements

* Bash
* Lua 5.3
* X11 window subsystem


# Installation

You need to compile and install TekUI window manager which is included
in this distribution.

Directory `tek_project/` contains source of GUI subsystem [TekUI 1.12]
(tekui). I've changed `LUAVER` variable in it's `config` file from
`5.1` to `5.3`. You need to install it before use.

```
$ cd tek_project
$ sudo make all install clean
```

# Uninstallation

`$ sudo rm -rf /usr/local/lib/lua/5.3/tek/`


# Usage

`$ lua lcf_params_gui.lua`

----

See also [my other repositories](repos)

[tekui]: (http://tekui.neoscientists.org/releases/tekui-1.12-r1.tgz)
[lcf]: (https://github.com/martin-eden/lua_code_formatter)
[repos]: (https://github.com/martin-eden/contents)