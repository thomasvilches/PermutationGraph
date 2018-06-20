include("PermutationGraph.jl")
a = [1,2,3,4]
EdgeList = true
Circ = zeros(Int64,length(a),length(a))
for i = 2:(n-1)
      Circ[i,(i-1)]=Circ[i,(i+1)]=1
end

Circ[1,n]=Circ[n,1]=Circ[1,2]=Circ[n,(n-1)]=1

A,B = PermutationGraph(a,Circ,EdgeList) ## The function receives an input vector, an adjacency matrix of the original graph (in this case a circle), and a boolean string, if
                                                        ##if true it returns the second element as an edge list, otherwise B is an adjacency matrix.
                                                        ### the first return element is a matrix in which the columns are each permutation 

writedlm("Connetions.dat",B)
writedlm("Permutations.dat",A)
