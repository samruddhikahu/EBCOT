function [CX, D] = zero_coding_HL(C,sigma,CX,D,mx,i,j)
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

if(V==2)
    CX(p) = 8;
elseif((V==1)&&(H>=1))
    CX(p) = 7;
elseif((V==1)&&(H==0)&&(Dd>=1))
    CX(p) = 6;
elseif((V==1)&&(H==0)&&(Dd==0))
    CX(p) = 5;
elseif((V==0)&&(H==2))
    CX(p) = 4;
elseif((V==0)&&(H==1))
    CX(p) = 3;
elseif((V==0)&&(H==0)&&(Dd>=2))
    CX(p) = 2;
elseif((V==0)&&(H==0)&&(Dd==1))
    CX(p) = 1;
elseif((V==0)&&(H==0)&&(Dd==0))
    CX(p) = 0;
end
    
end