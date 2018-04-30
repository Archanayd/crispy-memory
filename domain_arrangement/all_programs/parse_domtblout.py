#python parse_domtblout.py --file yourfile.domtblout --evalue 1e-05 --overlap 40


import argparse
from itertools import groupby
import re

usage = """%(prog)s reads .domtblout file and returns non-overlapped (or
specified percent of overlapping) domains below given e-value.
"""
p = argparse.ArgumentParser(description=usage)
p.add_argument("-f", "--f", "-file", "--file", dest="file",
                  help=".domtblout file")
p.add_argument("-e", "--e", "--evalue", "-evalue", type=float, dest="evalue",
                   help="E-value cut-off", default=1e-02)
p.add_argument("-o", "--o", "--overlap", "-overlap", type=int, dest="overlap",
             help="overlap cut-off (percent)", default=40)

args = p.parse_args()

fh = open(args.file)
oh = open(args.file + '.out', 'w')

grouper = lambda x: re.split('\s+', x)[3] if not x.startswith('#') else x[0]
# Iterate through proteins.
for k, g in groupby(fh, grouper):
    if k.startswith('#'): continue  # Skip header and footer of a domtblout file.
    l = []
    for line in g:
        sl = re.split('\s+', line)
        pid = sl[3]
        dname = sl[0]
        did = sl[1]
        plen = int(sl[5])
        dstart = int(sl[17])
        dend = int(sl[18])
        #evalue = float(sl[12])
        evalue = float(sl[11])

        desc = sl[22]
        if evalue <= args.evalue:
             l.append([dname, did, dstart, dend, evalue,plen,desc])
    
    # Filter domains by a given E-value and overlapping cut-off.
    filtered = []
    l.sort(key=lambda x: x[2])
    for i in range(0, len(l)):
        if i:
            dom1len = l[i][3] - l[i][2]
            dom2len = l[i-1][3] - l[i-1][2]
            domlen = sorted([dom1len, dom2len])[0]
            overlap = l[i-1][3] - l[i][2]
            if overlap/domlen*100 >= args.overlap:            
                continue
        filtered.append(l[i])

    # Save domains to a file.
    filtered.sort(key=lambda x: x[2])
    for d in filtered:
        oh.write('{0}\t{1}\t{2}\t{3}\t{4}\t{6}\n'.format(pid, *d))

fh.close()
oh.close()
