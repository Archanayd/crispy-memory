import numpy as np
import pylab as pl
data=np.loadtxt('test1.txt')
pl.plot(data[:,0],data[:,1])
pl.xlabel('x')
pl.ylabel('y')
pl.show()
