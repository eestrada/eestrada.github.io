---
title: Python wrapper for hscript
date: 2015-09-30T02:18:00-06:00
Author: Ethan Estrada
aliases: [/2015/09/python-wrapper-for-hscript.html]
Tags: [CGI, Houdini, Blogspot]
draft: false
---

Houdini has a nice little function in Python in the `hou` namespace called `hscript`.
You can pass in a string for an hscript command.
It passes back out a tuple with stdout and stderr strings.
This is dandy,
but it would be nice to call hscript commands with (in essence) Python syntax.
So I made a little class that does just that.

```python
class HscriptWrapper(object):
    commands = hou.hscript('help')[0]
    commands = frozenset(commands.split())

    def __getattr__(self, attr):
        if attr not in self.commands:
            raise AttributeError('No hscript command by name "%s"' % attr)
        # cache for future calls
        self.__dict__[attr] = rattr = self._command_factory(attr)
        return rattr

    def _command_factory(self, attr):
        def cmd(*args, **kwargs):
            fmt = '{cmd} {flags} {args}'
            hsargs = ' '.join(args)
            hsflags = []
            for k, v in kwargs.items():
                if isinstance(v, bool) and v is True:
                    hsflags.append('-' + k)
                else:
                    hsflags.append('-{0} {1}'.format(k, v))
            hsflags = ' '.join(hsflags)
            hscmd = fmt.format(cmd=attr, flags=hsflags, args=hsargs)
            return hou.hscript(hscmd)
        cmd.__name__ = attr
        cmd.__doc__ = hou.hscript('help {}'.format(attr))[0]
        return cmd
```

To use it, create an instance of the HscriptWrapper class,
then access hscript commands as attributes of the instance.
The returned attribute is a callable function that takes positional and keyword arguments.

This Python snippet:

```python
hswrap = HscriptWrapper()
hswrap.opfind('cam1', p='/')
```

Is equivalent to this hscript command:

```shell
opfind -p / cam1
```

Any positional arguments are passed through as positional arguments to hscript.
Keyword arguments are passed through as option flags with an argument.
If the value of a keyword argument is a boolean,
then the flag doesn't get created with an argument
and only gets created if the value is 'True'.
Thus, it is safe to write `hscmd(f=False)` and the `f` flag will **not** be included,
whereas `hscmd(f=True)` will include the flag with no trailing argument.

More complex hscript voodoo won't work with this setup,
but for simply calling an hscript command that has no python equivalent
and getting its output, this does the trick nicely.

It doesn't do any safe escaping of arguments yet.
For instance, if you have a file path with a space in it,
this will be detected as two arguments
instead of one argument with an embedded space.
That is next on the list.

The above code is placed in the public domain and is provided as is,
without express or implied warranty of any kind, to the extent allowable by law.
Use it however you like.
There is no requirement to attribute the code to me
(although any mention would be appreciated).
