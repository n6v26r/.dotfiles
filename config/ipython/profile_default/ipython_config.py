import subprocess
import sys
from pathlib import Path

import IPython
import IPython.terminal.prompts as prompts
import prompt_toolkit
from prompt_toolkit.application import get_app
from prompt_toolkit.application.current import get_app as get_current_app
from prompt_toolkit.key_binding.vi_state import InputMode, ViState
from prompt_toolkit.styles.pygments import pygments_token_to_classname
from prompt_toolkit.styles.style import Style
from pygments.token import (
    Comment,
    Error,
    Keyword,
    Literal,
    Name,
    Number,
    Operator,
    String,
    Text,
    Token,
)

c = get_config()  # type: ignore # noqa # pylint:disable=E0602

# Options
c.TerminalInteractiveShell.true_color = True
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalIPythonApp.display_banner = True
c.TerminalInteractiveShell.banner2 = '''
   ▄▀▀▀▄▄▄▄▄▄▄▀▀▀▄
   █▒▒░░░░░░░░░▒▒█
    █░░█░░░░░█░░█
 ▄▄  █░░░▀█▀░░░█  ▄▄ 
█░░█ ▀▄░░░░░░░▄▀ █░░█
█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
█░░╦ ╦╔╗╦ ╔╗╔╗╔╦╗╔╗░░█
█░░║║║╠ ║ ║ ║║║║║╠ ░░█
█░░╚╩╝╚╝╚╝╚╝╚╝╩ ╩╚╝░░█
█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█
'''

# Fix completion highlighting as per https://github.com/ipython/ipython/issues/11526
def my_style_from_pygments_dict(pygments_dict):
    """Monkey patch prompt toolkit style function to fix completion colors."""
    pygments_style = []
    for token, style in pygments_dict.items():
        if isinstance(token, str):
            pygments_style.append((token, style))
        else:
            pygments_style.append((pygments_token_to_classname(token), style))
    return Style(pygments_style)

class Prompt(prompts.Prompts):
    def in_prompt_tokens(self, cli=None):
        return [ ( Token.Prompt, f"[{self.shell.execution_count}]: "), ]

    def out_prompt_tokens(self, cli=None):
        return [ ( Token.OutPrompt, f"[{self.shell.execution_count}]: "), ]

c.TerminalInteractiveShell.prompts_class = Prompt

prompt_toolkit.styles.pygments.style_from_pygments_dict = my_style_from_pygments_dict
IPython.terminal.interactiveshell.style_from_pygments_dict = my_style_from_pygments_dict

base = '#1e1e2e'
mantle = '#181825'
crust = '#11111b'

white = '#cdd6f4'
subtext0 = '#a6adc8'
subtext1 = '#bac2de'

surface0 = '#313244'
surface1 = '#45475a'
surface2 = '#585b70'

overlay0 = '#6c7086'
overlay1 = '#7f849c'
overlay2 = '#9399b2'


blue = '#89b4fa'
lavender = '#b4befe'
sapphire = '#74c7ec'
sky = '#89dceb'
teal = '#94e2d5'
green = '#a6e3a1'
yellow = '#f9e2af'
peach = '#fab387'
maroon = '#eba0ac'
red = '#f38ba8'
mauve = '#cba6f7'
pink = '#f5c2e7'
flamingo = '#f2cdcd'
rosewater = '#f5e0dc'

cursor_grey = subtext0
gutter_fg_grey = subtext1
special_grey = surface0
visual_grey = surface1
pmenu = base
syntax_fg = white
syntax_fold_bg = surface2
count_bg = mantle
count_fg = lavender

# See:
# https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/src/prompt_toolkit/styles/defaults.py # noqa
c.TerminalInteractiveShell.highlighting_style = "catppuccin-mocha"
c.TerminalInteractiveShell.highlighting_style_overrides = {
    # Completion
    'completion-menu': f'bg:{pmenu} {white}',
    'completion-menu.completion.current': f'bg:{lavender} {crust}',
    'completion-menu.completion': f'bg:{pmenu} {white}',
    'completion-menu.meta.completion.current': f'bg:{lavender} {crust}',
    'completion-menu.meta.completion': f'bg:{pmenu} {white}',
    'completion-menu.multi-column-meta': f'bg:{pmenu} {white}',
}

# Run this code upon starting the shell
c.InteractiveShellApp.exec_lines = """
import numpy as np
import math

def load_extension_silently(extension):
    from IPython import get_ipython

    ip = get_ipython()
    try:
        ip.extension_manager.load_extension(extension)
    except ImportError:
        pass

load_extension_silently('ipython_ctrlr_fzf')
"""

