#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# TODO: Check that the given classification codes exist in the associated classification.
# TODO: Add extra data for the classification code title to check that the intended code was used?

import os
import csv

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

subjclasses_path = os.environ['BMTPATH']+'/subjclasses/'

# def get_classification_abbreviation(classification_name):
    # with open(subjclasses_path+'abbreviations.csv') as csv_file:
        # csv_reader = csv.reader(csv_file, delimiter=',')
        
        # classification_abbreviation = None
        # for row in csv_reader:
            # if row[1] == classification_name:
                # classification_abbreviation = row[0]
        
        # if classification_abbreviation is None:
            # print('Invalid classification name:', classification_name)
            # exit()

subjclassfile = open('subjclass.txt')
line = subjclassfile.readline()
no_lines = 0
while line:
    line = line.replace('\n', '')
    no_lines = no_lines + 1
    
    # advance line
    old_line = line
    line = subjclassfile.readline()
assert no_lines == 1

subjclasses = old_line.split('; ')
for subjclass in subjclasses:
    classification_name   = subjclass.split(': ')[0]
    classification_string = subjclass.split(': ')[1]
    
    if classification_name == 'Universal Decimal Classification':
        classification_abbreviation = 'UDC'
        classifications = classification_string.split('+')
    elif classification_name == 'Physics and Astronomy Classification Scheme':
        classification_abbreviation = 'PACS'
        classifications = classification_string.split(', ')
    else:
        print('Invalid classification name:', classification_name)
        exit()
    
    with open(subjclasses_path+classification_abbreviation.lower()+'.csv') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        
        valid_classifications = []
        for row in csv_reader:
            valid_classifications.append(row[0])
    
    for classification in classifications:
        if classification not in valid_classifications:
            print(color.RED+color.BOLD+'Invalid classification:', classification_abbreviation, classification+color.END)

#print('All classifications validated.')
