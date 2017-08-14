#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2013 Aswad Rangnekar <aswad.r@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
devenv: Initializes dev environments.
Tested/supported on:
    - Ubuntu
"""

import argparse
import os

from jinja2 import Environment, FileSystemLoader


CUR_DIR = os.path.dirname(os.path.abspath(__file__))
TEMPLATE_ENVIRONMENT = Environment(
    autoescape=False,
    loader=FileSystemLoader(os.path.join(CUR_DIR, 'templates')),
    trim_blocks=False)


def setup_env(context, file_path):
    data = TEMPLATE_ENVIRONMENT.get_template('Vagrantfile.tmpl').render(context)
    with open(file_path, 'w+') as f:
        f.write(data)

def parse_args():
    parser = argparse.ArgumentParser(prog=__file__, description=__doc__)
    parser.add_argument('-b', '--box_type', default="ubuntu/xenial64", help='guest OS <vagrant_box|ubuntu|centos>')
    parser.add_argument('-m', '--mem', default=1024, type=int, help='MEM in KBs for the box, defaults to 1024')
    parser.add_argument('-c', '--cpu', default=1, type=int, help='CPU in cores for the box, defaults to 1')
    parser.add_argument('-e', '--env_type', nargs='+', help='Provision env in box. <python|golang>')
    parser.add_argument('-f', '--port_forwarding', type=int, nargs='+', help='Guest port to port-forward')
    parser.add_argument('-p', '--path', help='Path for creating dev env')
    args = parser.parse_args()
    return args

def main():
    args = parse_args()

    context = {
        'box_type': args.box_type,
        'box_os': 'deb' if 'ubuntu' in args.box_type.lower() else 'rhel',
        'mem': args.mem,
        'cpu': args.cpu,
        'port_forwarding': args.port_forwarding or [],
        'provision_scripts': args.env_type or []
    }
    args.path = os.path.join(args.path or CUR_DIR, "Vagrantfile")
    setup_env(context, args.path)


if __name__ == "__main__":
    main()