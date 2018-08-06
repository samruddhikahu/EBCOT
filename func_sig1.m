function w = func_sig1(sigma, mx, i, j)
[m,n] = size(sigma);

if((mx==1)&&(i==1))
    wp = sigma(mx+i-1:mx+i,:);
elseif((mx+i-1)==m)
    wp = sigma(mx+i-2:m,:);
else
    wp = sigma(mx+i-2:mx+i,:);
end
if(j==1)
    w = wp(:,j:j+1);
elseif(j==n)
    w = wp(:,j-1:j);
else
    w = wp(:,j-1:j+1);
end
end