#!/opt/anaconda/bin/python


import os
os.environ[ 'MPLCONFIGDIR' ] = '/tmp/'

import sys
#print sys.path
#sys.path.append("/var/www/html/kixdomain/anaconda2/lib/python2.7/site-packages/")
#print sys.path
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import matplotlib.gridspec as grd
from pylab import *
from Bio import SeqIO
import glob


fasta_files = glob.glob("iupred/in_*.fa")


for txt in fasta_files:
    #print txt
	fh = open(txt, "r")
	filename = txt.split(".")[0] 
    #print filename 

	for record in SeqIO.parse(fh, "fasta"):
		id = record.id
        #print id
	img = id.split("|")[0]+"_"+id.split("|")[-1]
    	seq = record.seq
        #print seq
        num_residues = len(seq)
	fh.close()

	print filename

#fh = open(sys.argv[1],"r")
#fastafile = sys.argv[1]
#print fastafile
#filename = fastafile.split(".")[0]
#print filename
#for record in SeqIO.parse(fh, "fasta"):
#        id = record.id
#        img = id.split("|")[0]+"_"+id.split("|")[-1]
#        seq = record.seq
#        num_residues = len(seq)
#fh.close()

# Kyte & Doolittle index of hydrophobicity
	kd = { 'A': 1.8,'R':-4.5,'N':-3.5,'D':-3.5,'C': 2.5,
			'Q':-3.5,'E':-3.5,'G':-0.4,'H':-3.2,'I': 4.5,
			'L': 3.8,'K':-3.9,'M': 1.9,'F': 2.8,'P':-1.6,
			'S':-0.8,'T':-0.7,'W':-0.9,'Y':-1.3,'V': 4.2 }

	values = []
	for residue in seq:
		values.append(kd[residue])



	def add_secondary_struct_icons(ax,ss,bounds):
		for l in range(len(ss)):
			sec_str = ss[l]
			ss_bounds = bounds[l]
			#print sec_str
			if sec_str == "H":
				xpos = ss_bounds[0]
				xdim = ss_bounds[1]
				#print xdim
				#print xdim
				ypos = .15
				ydim = 0.4
				patch1 = mpatches.Rectangle((xpos,ypos), xdim, ydim, facecolor="blue",alpha=0.7,ec='b')
				#patch1 = mpatches.Rectangle((xpos,ypos), xdim, ydim, facecolor="blue",alpha=0.7,ec='b')
			if sec_str == "E":
				xpos = ss_bounds[0]
				xdim = ss_bounds[1]
				ypos = 0.35
				patch1 = mpatches.Arrow(xpos, ypos, xdim,0, width=0.8,color='pink',alpha=0.7,ec='k')
	
			temp = ax.add_patch(patch1)
			temp.set_clip_on(False)
		
	f1 = open(filename+'sec_str.ss2', 'r')
# read the whole file into a single variable, which is a list of every row of the file.
	lines = f1.readlines()
	#print lines
	f1.close()

# initialize some variable to be lists:
	var1 = []
	var2 = []

# scan the rows of the file stored in lines, and put the values into some variables:
	for line in lines:
   		a = line.split()
   		var1.append(int(a[0]))
   		var2.append(a[2])

	positions = np.array(var1)
	ss_pred = np.array(var2)
	#print positions
	elements = zip(ss_pred,positions)
	#print ele




	
	#elements = [('H',2),('H',3),('H',4),('H',5),('B',10),('B',11),('B',12),('H',13),('H',14),('H',15)]
	list1 =[]
	list2 =[]
	H_arr = []
	B_arr = []
	xpos =[]
	xdim=[]
	ss=[]
	for i in range(len(elements)):
		element = elements[i][0]
		if element.startswith("H"):
			list1.append(elements[i][1])
		elif element.startswith("E"):
			list2.append(elements[i][1])
	H_arr = np.split(list1, np.where(np.diff(list1)>1)[0] +1)
	for j in range(len(H_arr)):
		#xpos = min(H_arr[j])
		xpos.append(min(H_arr[j]))
		xlast = max(H_arr[j])
		xdim.append(xlast-min(H_arr[j]))
		ss.append("H")
	if list2:
		B_arr = np.split(list2, np.where(np.diff(list2)>1)[0] +1)
		for k in range(len(B_arr)):
			xpos.append(min(B_arr[k]))
			#xpos = min(B_arr[k])
			xlast_B = max(B_arr[k])
			#xdim = xlast_B - xpos
			xdim.append(xlast_B - min(B_arr[k]))
			ss.append("E")

	
	bounds= zip(xpos,xdim)
	#print bounds
	#print ss
	gs = grd.GridSpec(3,1, height_ratios=[3,5,2], wspace=0.01, hspace = 0)
	#gs = grd.GridSpec(2, 2, height_ratios=[10,1], width_ratios=[6,1], wspace=0.1)
	fig = plt.figure()
	ax = fig.add_subplot(gs[2, :])
	#axhline(y=0.35, linewidth=0.5, color='b')
	#ax = fig.add_subplot(111, aspect='equal')
	add_secondary_struct_icons(ax,ss,bounds)


#---------------------read disorderness--------------------------------------
	#f2 = open('test.txt', 'r')
	f2 = open(filename+'_dis.txt', 'r')
	# read the whole file into a single variable, which is a list of every row of the file.
	lines = f2.readlines()
	f2.close()

# initialize some variable to be lists:
	x1 = []
	y1 = []

# scan the rows of the file stored in lines, and put the values into some variables:
	for line in lines:
		p = line.split()
		x1.append(float(p[0]))
		y1.append(float(p[2]))

	xv = np.array(x1)
	yv = np.array(y1)

	ax2 = fig.add_subplot(gs[1], sharex=ax)
	# now, plot the data:
	#ax.tick_params(axis='x', labelsize=4)

	#xmin, xmax = ax.get_xaxis().get_view_interval()
	#ymin, ymax = ax.get_yaxis().get_view_interval()
	#ax.add_artist(Line2D((0, 100), (ymin, ymin), color='black', linewidth=1))
	ax.set_xticks(range(0,len(x1)+5,5))
	ax.set_yticks(range(0,1,1))
	#ax.spines['right'].set_visible(False)
	ax.spines['top'].set_visible(False)  
	ax.xaxis.set_ticks_position('bottom')
	#ax.yaxis.set_ticks_position('left') 
	#ax.yaxis.set_ticks_position('right') 
	plt.setp(ax.get_yticklabels(), visible=False)
	ax.set_xlabel("residue number")
	ax.set_ylabel("sec str")
	ax2.plot(xv,yv, 'g')
	#ax2.plot(xv,yv, 'g')
	plt.setp(ax2.get_xticklabels(), visible=False)

	#plt.plot(xv, yv)
	axhline(y=0.5, linewidth=0.5, color='b')
	ylabel("disorderness")

#--------------hydrophobicity----------------------------------

## Plot the hydrophobicity values

# Normally "range" starts with 0, which is what Python expects.
# This output is meant for biologists, who expect sequence
# coordinates to start with 1, so shift things by 1.
	x_data = range(1, num_residues+1)

	ax3 = fig.add_subplot(gs[0],sharex=ax )
	ax3.plot(x_data, values, linewidth=1.0)
	axhline(linewidth=0.5, color='r')
	# Show exactly the length of the sequence
	axis(xmin = 1, xmax = num_residues)
	plt.setp(ax3.get_xticklabels(), visible=False)
	#xlabel("residue number")
	ylabel("hydrophobicity")
	ax3.yaxis.set_label_position("right")
	title("Graph for " + id)
	ax3.yaxis.set_ticks_position('right') 
	fig.savefig(img+'.png')

