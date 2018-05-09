using Permutations
using Base.LinAlg.Tridiagonal

input = [1,2,3,4]

## Making the Permutation

function PermutationGraph(input,Circ,list::Bool)
    n = length(input)
    nPerm = factorial(n)

    PermutationMatrix = Matrix{typeof(input[1])}(n,nPerm)

    for i = 1:nPerm
        p = Permutation(n,i)
        PermutationMatrix[:,i] = input[p.data]
    end

    ################################
#=     Circ = zeros(Int64,n,n)
    for i = 2:(n-1)
        Circ[i,(i-1)]=Circ[i,(i+1)]=1
    end

    Circ[1,n]=Circ[n,1]=Circ[1,2]=Circ[n,(n-1)]=1 =#

    ConnectionMatrix = zeros(Int64,nPerm,nPerm)

    for i = 1:(nPerm-1)
        for j = i:nPerm
            for k = 1:(n-1)
                if PermutationMatrix[1:(k-1),i]==PermutationMatrix[1:(k-1),j] && PermutationMatrix[k,i]!=PermutationMatrix[k,j] && PermutationMatrix[(k+1),i]!=PermutationMatrix[(k+1),j] && PermutationMatrix[(k+2):n,i]==PermutationMatrix[(k+2):n,j]
                    aK = find(x -> x == PermutationMatrix[k,i],input)
                    aK1 = find(x -> x == PermutationMatrix[(k+1),i],input)
                        if Circ[aK,aK1]!= ones(Int64,1,1)
                            ConnectionMatrix[i,j] = ConnectionMatrix[j,i] = 1
                            break
                        end
                end
            end

        end
    end

    if list == true
        Nlist = sum(ConnectionMatrix)
        NumberLines::Int64 = Nlist/2
        EdgeList = Matrix{Int64}(NumberLines,2)
        line = 1
        for i = 1:nPerm
            for j = i:nPerm
                if ConnectionMatrix[i,j] == 1
                    EdgeList[line,1] = i
                    EdgeList[line,2] = j
                    line+=1
                end
            end
        end

        return PermutationMatrix,EdgeList
    else 
        return PermutationMatrix,ConnectionMatrix
    end

end