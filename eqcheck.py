#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import configparser
import re
import os
import sys

# https://stackoverflow.com/a/17303428/1124489
class color:
    PURPLE = '\033[95m'
    CYAN = '\033[96m'
    DARKCYAN = '\033[36m'
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    END = '\033[0m'

# Get all equation labels.
# Starting point: https://tex.stackexchange.com/a/296873/9945

tex_equation_labels = []
tex_equations = []
for root, dirs, files in os.walk('./'):
    for filename in files: 
        with open(os.path.join(root, filename)) as f:
            if filename.endswith(".tex"):
                text = f.read()
                tex_equation_labels.extend(re.findall(re.compile("\\\label{eq:(.*?)}"), text))
                tex_equations.extend(re.findall(re.compile("\\\\begin{equation}"), text))
                tex_equations.extend(re.findall(re.compile("\\\\begin{align}"), text))
                
                # If performance of the regex line is a problem in the future: https://blog.stevenlevithan.com/archives/greedy-lazy-performance

config = configparser.ConfigParser()
config.read(sys.argv[1])
ini_equation_labels = config.sections()

if len(tex_equation_labels) < len(tex_equations):
    print(color.RED+color.BOLD+'Not all equation and/or align environments have labels.'+color.END)
    # TODO: Determine line numbers of equation environments without labels.

for tex_equation_label in tex_equation_labels:
    if not(tex_equation_label in ini_equation_labels):
        print(color.RED+color.BOLD+'Equation missing from eqcheck file:', tex_equation_label+color.END)

for ini_equation_label in ini_equation_labels:
    if not(ini_equation_label in tex_equation_labels):
        print(color.RED+color.BOLD+'Equation missing from TeX file:', ini_equation_label+color.END)
