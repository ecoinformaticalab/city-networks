#Generar matriz HW
library(dplyr)
library(rstudioapi)   

#Firstly we obtain the path where "Generate-OD-matrix-undirected.R" is located
path<-print(rstudioapi::getActiveDocumentContext()$path)
folder<-gsub("Generate-OD-Matrix-undirected.R","",path)

#The file where the trajectories list is allocated is called "list.csv"
#it has two columns, first called "Origin" and has the origin labels and the second called "Destination" with destination labels.
read_file<-paste(folder,"list.csv",sep="")

HW <-read.csv(read_file,header=TRUE)
c1<-data.frame(HW[,1])
c2<-data.frame(HW[,2])
colnames(c1)<-c("labels")
colnames(c2)<-c("labels")
names(c1)
a<-bind_rows(c1,c2)
aa<-data.frame(a[,1])
Nodes<-unique(aa)
colnames(Nodes)<-c("labels")


M<-matrix(0, nrow = length(Nodes[,1]), ncol = length(Nodes[,1]))
colnames(M)<-Nodes[,"labels"]
rownames(M)<-Nodes[,"labels"]

for (i in 1:length(HW[,1])) {
fila<-as.character(HW[i,"Origin"])
columna<-as.character(HW[i,"Destination"])
M[fila,columna]=M[fila,columna]+1


M[columna,fila]=M[columna,fila]+1
}

write.csv(M, file = paste(folder,"OD_Matrix_undirected.csv"))