#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Suggested replacements go in the second column, with explanations in parentheses. Use \b to start words like in regular expressions, but don't use \b to end words.

# Third column:
# b - beginner mistakes?
# ! - commented out?

import sys
import csv

assert(sys.argv[1].endswith('.csv'))
print('Reading:', sys.argv[1])

outfile = open(sys.argv[1][0:-4]+'.diction', 'w')

with open(sys.argv[1]) as csv_file:
   csv_reader = csv.reader(csv_file, delimiter=',')
   
   num_rows = 0
   prev_first_col = None
   for row in csv_reader:
      #print(row[0])
      assert(len(row) == 2)
      assert(row[0] != '')
      assert(row[1] != '')
      if prev_first_col == row[0]:
         sys.exit('Duplicate: '+row[0])
      num_rows = num_rows + 1
      if row[0].startswith('\\b'):
         outfile.write(' '+row[0][2:]+'\t'+row[1]+'\n')
      else:
         outfile.write(row[0]+'\t'+row[1]+'\n')
      prev_first_col = row[0]

print(num_rows, 'lines converted.')

outfile.close()
