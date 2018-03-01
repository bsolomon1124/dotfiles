"""IPython (v. 6.0+) configuration file."""

# To create: $ ipython profile create
# http://ipython.readthedocs.io/en/stable/config/index.html
# http://ipython.readthedocs.io/en/stable/config/options/terminal.html

import IPython

c = get_config()
c.TerminalInteractiveShell.prompts_class = IPython.terminal.prompts.ClassicPrompts
c.TerminalIPythonApp.display_banner = False
c.InteractiveShell.automagic = True
c.InteractiveShell.history_load_length = 25000
c.TerminalInteractiveShell.confirm_exit = False
c.PlainTextFormatter.max_seq_length = 250
c.InteractiveShell.xmode = 'Plain'
c.InteractiveShell.banner1 = ''

