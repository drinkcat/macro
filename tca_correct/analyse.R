#!/usr/bin/R

db = read.table("params.db", header=TRUE)

# Nice boxplot of the data
dbplot = db
dbplot$r3 = 1-dbplot$r3
dbplot$b3 = 1-dbplot$b3

names = paste(rep(c(rep("",3), "1-"),2), colnames(dbplot), sep="")

pdf("params.pdf", width=8, height=4)
par(mar=c(3, 3, 3, 1) + 0.1);
boxplot(dbplot, names=names, main="fulla parameters")
dev.off()

# Use the median of each parameter
params = sapply(db, median)

sprintf("fulla -r %f:%f:%f:%f -b %f:%f:%f:%f",
  params[1], params[2], params[3], params[4],
  params[5], params[6], params[7], params[8])

