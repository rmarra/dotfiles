#!/usr/bin/env python3
import os
import uuid
from pathlib import PosixPath

import yaml
import libtmux
import tmuxp

HOME = PosixPath(os.getenv('HOME'))
tmuxp_dir = os.getenv('TMUXP_DIR') or (HOME / '.tmuxp')

server = libtmux.Server()

print('Would you like to laod any tmux template?\n')

tmuxp_configs = []
for index, item in enumerate(tmuxp_dir.iterdir()):
    path_abs = str(tmuxp_dir / item)
    f = open(path_abs, 'r')
    config = yaml.load(f)
    tmuxp_configs.append(path_abs)
    print('[{index}] {config_name}'.format(
        index=(index + 1), config_name=config.get('session_name')))

print()
try:
    arg = int(input('Session ([0] for new one): ')) - 1
    tmuxp.cli.load_workspace(tmuxp_configs[(arg - 1)])
except (IndexError, ValueError):
    pass

session_name = '{}-{}'.format('TMP', uuid.uuid4())
server.new_session(session_name=session_name, attach=True)
