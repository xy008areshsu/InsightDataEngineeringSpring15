#!/usr/bin/python

"""
This is the code for the normal implementation of the word count problem.
It uses a dictionary as the data structure, and reads each line of the file,
then updates each word of the line into the dictionary.
"""

import sys
import string

wc_count = {}

for line in sys.stdin:
    words = line.lower().strip().split()
    for w in words:
        for c in string.punctuation:
            w = w.replace(c, '')
        w = w.strip()
        if w == '':
        	continue
        if w in wc_count:
            wc_count[w] += 1
        else:
            wc_count[w] = 1

for key in sorted(wc_count):
    print('{0}\t{1}'.format(key, wc_count[key]))
