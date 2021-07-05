#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import csv

assert(sys.argv[1].endswith('.csv'))
print('Reading:', sys.argv[1])

all_lines = []
with open(sys.argv[1]) as csv_file:
   csv_reader = csv.reader(csv_file, delimiter=',')
   
   num_rows = 0
   prev_first_col = None
   prev_second_col = None
   prev_third_col = None
   for row in csv_reader:
      print(row[0])
      assert(len(row) == 3)
      assert(row[0] != '')
      assert(row[1] != '')
      # TODO: assert('(' in row[1])
      # TODO: assert(')' in row[1])
      assert(not('#' in row[0][1:]))
      assert(not('#' in row[1]))
      assert(not(' )' in row[1]))
      assert(not('TODO' in row[0]))
      assert(not('TODO' in row[1]))
      if prev_first_col == row[0]:
         print('Duplicate: '+row[0]+' ('+sys.argv[1]+')')
         second_col = None
         third_col = None
         if len(prev_second_col) > len(row[1]):
            second_col = prev_second_col
         else:
            second_col = row[1]
         if len(prev_third_col) > len(row[2]):
            third_col = prev_third_col
         else:
            third_col = row[2]
         all_lines.pop()
         all_lines.append([row[0], second_col, third_col])
      else:
         all_lines.append([row[0], row[1], row[2]])
         
      num_rows = num_rows + 1
      prev_first_col  = row[0]
      prev_second_col = row[1]
      prev_third_col  = row[2]

print(num_rows, 'lines converted.')

outfile = open(sys.argv[1][0:-4]+'_cleaned.csv', 'w')
outwriter = csv.writer(outfile, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)

for row in all_lines:
   outwriter.writerow([row[0], row[1], row[2]])
   outfile.flush()

outfile.close()
