function [CX, D] = zero_coding_LHLL(C,sigma,CX,D,mx,i,j)
p = length(D) + 1;
D(p) = C(1);
[m,n] = size(sigma);

if(((mx+i-1)==1)&&(j==1))
    Dd = sigma(mx+i,j+1);
    H = sigma(mx+i-1,j+1);
    V = sigma(mx+i,j);
elseif(((mx+i-1)==1)&&(j>1)&&(j<n))
    Dd = sigma(mx+i,j-1) + sigma(mx+i,j+1);
    H = sigma(mx+i-1,j-1) + sigma(mx+i-1,j+1);
    V = sigma(mx+i,j);
elseif(((mx+i-1)==1)&&(j==n))
    Dd = sigma(mx+i,j-1);
    H = sigma(mx+i-1,j-1);
    V = sigma(mx+i,j);
elseif(((mx+i-1)==m)&&(j==1))
    Dd = sigma(mx+i-2,j+1);
    H = sigma(mx+i-1,j+1);
    V = sigma(mx+i-2,j);
elseif(((mx+i-1)==m)&&(j>1)&&(j<n))
    Dd = sigma(mx+i-2,j-1) + sigma(mx+i-2,j+1);
    H = sigma(mx+i-1,j-1) + sigma(mx+i-1,j+1);
    V = sigma(mx+i-2,j);
elseif(((mx+i-1)==m)&&(j==n))
    Dd = sigma(mx+i-2,j-1);
    H = sigma(mx+i-1,j-1);
    V = sigma(mx+i-2,j);
elseif(((mx+i-1)>1)&&(j==1))
    Dd = sigma(mx+i-2,j+1) + sigma(mx+i,j+1);
    H = sigma(mx+i-1,j+1);
    V = sigma(mx+i-2,j) + sigma(mx+i,j);
elseif(((mx+i-1)>1)&&(j==n))
    Dd = sigma(mx+i-2,j-1) + sigma(mx+i,j-1);
    H = sigma(mx+i-1,j-1);
    V = sigma(mx+i-2,j) + sigma(mx+i,j);
else
    Dd = sigma(mx+i-2,j-1) + sigma(mx+i-2,j+1) + sigma(mx+i,j-1) + sigma(mx+i,j+1);
    H = sigma(mx+i-1,j-1) + sigma(mx+i-1,j+1);
    V = sigma(mx+i-2,j) + sigma(mx+i,j);
end

if(H==2)
    CX(p) = 8;
elseif((H==1)&&(V>=1))
    CX(p) = 7;
elseif((H==1)&&(V==0)&&(Dd>=1))
    CX(p) = 6;
elseif((H==1)&&(V==0)&&(Dd==0))
    CX(p) = 5;
elseif((H==0)&&(V==2))
    CX(p) = 4;
elseif((H==0)&&(V==1))
    CX(p) = 3;
elseif((H==0)&&(V==0)&&(Dd>=2))
    CX(p) = 2;
elseif((H==0)&&(V==0)&&(Dd==1))
    CX(p) = 1;
elseif((H==0)&&(V==0)&&(Dd==0))
    CX(p) = 0;
end
    
end