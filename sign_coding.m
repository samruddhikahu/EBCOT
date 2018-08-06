function [CX, D] = sign_coding(chi,sigma,CX,D,mx,i,j)
[m,n] = size(sigma);
load('Table_SC.mat');
p = length(D) + 1;

if(j==1)
    H = min(1,max(-1,sigma(mx+i-1,j+1)*(1-2*chi(mx+i-1,j+1))));
elseif(j==n)
    H = min(1,max(-1,sigma(mx+i-1,j-1)*(1-2*chi(mx+i-1,j-1))));
else
    H = min(1,max(-1,(sigma(mx+i-1,j-1)*(1-2*chi(mx+i-1,j-1))) + (sigma(mx+i-1,j+1)*(1-2*chi(mx+i-1,j+1)))));
end

if((mx+i-1)==1)
    V = min(1,max(-1,sigma(mx+i,j)*(1-2*chi(mx+i,j))));
elseif((mx+i-1)==m)
    V = min(1,max(-1,sigma(mx+i-2,j)*(1-2*chi(mx+i-2,j))));
else
    V = min(1,max(-1,(sigma(mx+i-2,j)*(1-2*chi(mx+i-2,j))) + (sigma(mx+i,j)*(1-2*chi(mx+i,j)))));
end

Arr = (Table_SC(:,1)==H).*(Table_SC(:,2)==V);
Idx = find(Arr);

Xc = Table_SC(Idx,3);
CX(p) = Table_SC(Idx,4);
D(p) = num2str(xor(Xc,chi(mx+i-1,j)));
%chi(mx+i-1,j) = str2num(D(p));
end