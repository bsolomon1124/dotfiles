"""Make IPython look (mostly) like Python (but still behave like IPython).

This adds some stuff on top of what running `IPython --classic` will
give you.  For the differences, see the `classic_config` instance
that's defined in IPython/terminal/ipapp.py - that's what --classic
translates to.

To use, first run:

    ipython profile create

in your terminal, then overwrite the created file with this one.

Examples:

$ ipython
IPython 7.3.0 | CPython 3.7.2 | Linux 4.15.0-1035-aws | 2019-05-06 16:07:15
>>> def f(x):
...     return x ** 2

$ ipython
IPython 7.0.1 | CPython 3.7.3 | Darwin 17.7.0 | 2019-05-06 12:07:05
>>> %timeit pass
9.44 ns ± 0.0394 ns per loop (mean ± std. dev. of 7 runs, 100000000 loops each)
"""

import datetime
import os
import platform
import sys

import IPython


def get_version_info() -> str:
    ipython = "IPython %s" % IPython.__version__  # I.e. "IPython 7.3.0"
    # Taken directly from master/requests/help.py
    implementation = platform.python_implementation()  # I.e. CPython
    if implementation == "CPython":
        implementation_version = platform.python_version()
    elif implementation == "PyPy":
        implementation_version = "%s.%s.%s" % (
            sys.pypy_version_info.major,
            sys.pypy_version_info.minor,
            sys.pypy_version_info.micro,
        )
        if sys.pypy_version_info.releaselevel != "final":
            implementation_version = "".join(
                [implementation_version, sys.pypy_version_info.releaselevel]
            )
    elif implementation == "Jython":
        implementation_version = platform.python_version()  # Complete Guess
    elif implementation == "IronPython":
        implementation_version = platform.python_version()  # Complete Guess
    else:
        implementation_version = "[Unknown]"
    implstr = "%s %s" % (implementation, implementation_version)
    # I.e. 'Linux 4.15.0-1035-aws'
    try:
        sys_rel = " ".join((platform.system(), platform.release()))
    except IOError:
        sys_rel = "[unknown system]"
    now = datetime.datetime.now(
        datetime.timezone.utc
    ).strftime("%Y-%m-%d %H:%M:%S %Z")
    return " | ".join((ipython, implstr, sys_rel, now)) + os.linesep


c = get_config()  # noqa

# See:
# https://github.com/ipython/ipython/blob/master/IPython/terminal/prompts.py
c.TerminalInteractiveShell.prompts_class = (
    IPython.terminal.prompts.ClassicPrompts
)
c.TerminalInteractiveShell.quiet = True

# Not documented - this controls the newlines before/after prompts
c.TerminalInteractiveShell.separate_in = ""  # Default '\\n'
c.TerminalInteractiveShell.separate_out = ""
c.TerminalInteractiveShell.separate_out2 = ""

# https://github.com/ipython/ipython/blob/master/IPython/utils/PyColorize.py
c.TerminalInteractiveShell.colors = "Linux"

# Use our custom banner from above
c.TerminalInteractiveShell.banner1 = get_version_info()
c.TerminalInteractiveShell.banner2 = ""

# Enable magic commands to be called without the leading %
c.InteractiveShell.automagic = True

# The number of saved history entries to be loaded into the history
# buffer at startup.  Default: 1000
c.InteractiveShell.history_load_length = 10000

# By typing ‘exit’ or ‘quit’, you can force a direct exit without
# any confirmation
c.TerminalInteractiveShell.confirm_exit = False

# Truncate large collections (lists, dicts, tuples, sets) to this size
# Default 0
c.PlainTextFormatter.max_seq_length = 250

# Switch modes for the IPython exception handlers
c.InteractiveShell.xmode = "Plain"
