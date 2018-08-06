function [s, chi] = sign_decoding(sigma,chi,CX,D,p,mx,i,j)
[m,n] = size(sigma);
load('Table_SC.mat');
%p = p + 1;

if(CX(p)==9)
end
% if(CX(p)==9)
%     idx = 5;
%     Xc = Table_SC(idx,3);
%     
% elseif(CX(p)==10)
%     H = 0;
%     if((mx+i-1)==1)
%         V = min(1,max(-1,sigma(mx+i,j)*(1-2*chi(mx+i,j))));
%     elseif((mx+i-1)==m)
%         V = min(1,max(-1,sigma(mx+i-2,j)*(1-2*chi(mx+i-2,j))));
%     else
%         V = min(1,max(-1,(sigma(mx+i-2,j)*(1-2*chi(mx+i-2,j))) + (sigma(mx+i,j)*(1-2*chi(mx+i,j)))));
%     end
%     if(V==-1)
%         Xc = 1;
%     else
%         Xc = 0;
%     end
% end

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

chi(mx+i-1,j) = xor(Xc,str2num(D(p)));
if(chi(mx+i-1,j)==1)
    s = -1;
else
    s = 1;
end
        
end