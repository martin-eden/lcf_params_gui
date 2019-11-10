### Description

Generate command-line call text according selected widgets.

Yo dawg I herd you like GUIs so we provided GUI to generate
command-line text in your GUI.

It generates Bash text to call [Lua code formatter][lcf] to reformat
given file with selected parameters. You still have to add name of file
at the end of generated text by yourself.

![lcf_params_gui window 2018-07-07][snapshot]

This is experimental project. Intention is to ease start of usage
command-line tool. And display all possible options and their relations
on one screen.

### Licenses

TekUI - MIT,
@this - GPLv3


### Requirements

* Bash
* Lua 5.3
* X11 window subsystem


### TekUI installation

You need to download, compile and install [TekUI][tekui] window manager.

```
$ wget http://tekui.neoscientists.org/releases/tekui-1.12-r1.tgz
$ tar -xvf tekui-1.12-r1.tgz
$ cd tekui-1.12-r1
$ sudo make LUAVER=5.3 all install clean
```
Test for successful installation: `$ lua -l tek.ui`.

### TekUI removal

`$ sudo rm -rf /usr/local/lib/lua/5.3/tek`
`$ sudo rm -rf /usr/local/share/lua/5.3/tek`

### Usage

`$ lua lcf_params_gui.lua`

----

See also [my other repositories][repos].

[tekui]: http://tekui.neoscientists.org/
[lcf]: https://github.com/martin-eden/lua_code_formatter
[repos]: https://github.com/martin-eden/contents
[snapshot]: https://user-images.githubusercontent.com/20048064/42449231-8535fc0c-8388-11e8-9e2e-c8133d7b3a79.png
