#!/usr/bin/python

"""
This is the mapper function for the hadoop mapreduce. It reads each line of the file,
and prints out the key\tvalue pair, where key is the word, and value is the single 
count of this word, namely 1.
"""

import sys
import string

for line in sys.stdin:
    words = line.lower().strip().split()
    for w in words:
        for c in string.punctuation:
            w = w.replace(c, '')
        print('{0}\t{1}'.format(w, 1))


