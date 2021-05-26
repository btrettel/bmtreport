#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import configparser
import re
import os
import sys

# Get all equation labels.
# Starting point: https://tex.stackexchange.com/a/296873/9945

# regex to find equation labels
pattern = re.compile("\\\label{eq:(.*?)}")
# If performance of the previous line is a problem in the future: https://blog.stevenlevithan.com/archives/greedy-lazy-performance

tex_equation_labels = []
for root, dirs, files in os.walk('./'):
   for filename in files: 
      with open(os.path.join(root, filename)) as f:
         if filename.endswith(".tex"):
            text = f.read()
            tex_equation_labels.extend(re.findall(pattern, text))

config = configparser.ConfigParser()
config.read(sys.argv[1])
ini_equation_labels = config.sections()

for tex_equation_label in tex_equation_labels:
   if not(tex_equation_label in ini_equation_labels):
      sys.exit('Equation missing from eqcheck file: '+tex_equation_label)

for ini_equation_label in ini_equation_labels:
   if not(ini_equation_label in tex_equation_labels):
      sys.exit('Equation missing from TeX file: '+ini_equation_label)
