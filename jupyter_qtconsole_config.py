# flake8: noqa
# Configuration file for jupyter-qtconsole.


## Set to display confirmation dialog on exit. You can always use 'exit' or
#  'quit', to force a direct exit without any confirmation.
c.JupyterConsoleApp.confirm_exit = False

## Whether to display a banner upon starting the QtConsole.
c.JupyterQtConsoleApp.display_banner = False

## Start the console window with the menu bar hidden.
#c.JupyterQtConsoleApp.hide_menubar = False

## Start the console window maximized.
#c.JupyterQtConsoleApp.maximize = False

## The maximum number of lines of text before truncation. Specifying a non-
#  positive number disables text truncation (not recommended).
c.ConsoleWidget.buffer_size = 100

## The height of the console at start time in number of characters (will double
#  with `vsplit` paging)
c.ConsoleWidget.console_height = 50

## The width of the console at start time in number of characters (will double
#  with `hsplit` paging)
c.ConsoleWidget.console_width = 90

## The font family to use for the console. On OSX this defaults to Monaco, on
#  Windows the default is Consolas with fallback of Courier, and on other
#  platforms the default is Monospace.
#c.ConsoleWidget.font_family = ''

## The font size. If unconfigured, Qt will be entrusted with the size of the
#  font.
#c.ConsoleWidget.font_size = 0

## Whether to ask for user confirmation when restarting kernel
c.FrontendWidget.confirm_restart = True

## A command for invoking a system text editor. If the string contains a
#  {filename} format specifier, it will be used. Otherwise, the filename
#  will be appended to the end the command.
#c.JupyterWidget.editor = 'notepad'

## A CSS stylesheet. The stylesheet can contain classes for:
#      1. Qt: QPlainTextEdit, QFrame, QWidget, etc
#      2. Pygments: .c, .k, .o, etc. (see PygmentsHighlighter)
#      3. QtConsole: .error, .in-prompt, .out-prompt, etc
#c.JupyterWidget.style_sheet = ''
