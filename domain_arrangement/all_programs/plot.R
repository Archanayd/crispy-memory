#!/usr/bin/env Rscript

# convert protein GTF format to rectangle blocks for domains

args = commandArgs(trailingOnly=TRUE)

inputfile = args[1]
outputfile = gsub("([\\w/]+).g.f","\\1.pdf",inputfile,perl=TRUE)
#outputfile = gsub("([\\w/]+).g.f","\\1.png",inputfile,perl=TRUE)


gtftab = read.table(inputfile,header=FALSE,sep="\t")

# separate features by category

protnames = unique(gtftab[,1])
numprots = length(protnames)

# get domain position information
protindex = match(gtftab[,1],protnames)
yupper = protindex*10-3
ylower = protindex*10-7
domstart = gtftab[,4]
domend = gtftab[,5]

# domain codes for legend and color coding
domaincodes = gtftab[,3]
domnames = unique(domaincodes)
numdomains = length(domnames)
domainindex = match(domaincodes,domnames)
colvec = rainbow(numdomains, alpha=0.8)
domainids = gtftab[,2]

# OUTPUT
pdf(outputfile, width=10, height=numprots+2)
#png(outputfile)

par(mar=c(2.5,2.5,1,2) )

maxend = max(gtftab[,6]) #graph margins

protlenrange = pretty(c(0,maxend))

plot(0,0,type='n',xlim=c(0,max(protlenrange)),ylim=c(0,numprots*11+10),frame.plot=FALSE,xlab="",ylab="",yaxt="n")

# make black lines for length of the protein
# this works even if no protein types are given, instead just does not draw lines
ymiddles = match(gtftab[,1],protnames)*10-5
linexcoords = c(rbind(0,gtftab[,6],NA,NA))
lineycoords = c(rbind(ymiddles,ymiddles,NA,NA))
lines(linexcoords,lineycoords, lwd=2)


# draw domains as rectangles
axis(1,at=protlenrange)
rect(domstart, ylower, domend, yupper, col=colvec[domainindex])
text(c(0),match(protnames,protnames)*10-1, protnames, pos=4, offset=0)
legend(0,numprots*11+10,legend=domainids[match(domnames,domaincodes)],col=colvec,pch=15,x.intersp=0.5,ncol=6)
dev.off()