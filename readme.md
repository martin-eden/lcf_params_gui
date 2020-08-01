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

TekUI - MIT, this project - GPLv3.

### Requirements

* Bash
* Lua 5.3

### [TekUI installation][tekui-setup]

### Usage

`lua5.3 lcf_params_gui.lua`

----

See also [my other repositories][repos].

[tekui-setup]: https://gist.github.com/martin-eden/e721436788994e5b183e94fb2f84b30b
[lcf]: https://github.com/martin-eden/lua_code_formatter
[repos]: https://github.com/martin-eden/contents
[snapshot]: https://user-images.githubusercontent.com/20048064/42449231-8535fc0c-8388-11e8-9e2e-c8133d7b3a79.png
