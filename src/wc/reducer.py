#!/usr/bin/python

"""
This is the reduce function, it will do the following:
Loop around the data, it will be in the format key\tval
where key is the word, val is the number of counts
"""

import sys

counts = 0
old_key = None

for line in sys.stdin:
    data_mapped = line.strip().split("\t")
    if len(data_mapped) != 2:
        # Something has gone wrong. Skip this line.
        continue

    this_key, this_sale = data_mapped

    if old_key and old_key != this_key:
        print('{0}\t{1}'.format(old_key, counts))
        old_key = this_key;
        counts = 0

    old_key = this_key
    counts += int(this_sale)

if old_key != None:
    print('{0}\t{1}'.format(old_key, counts))


