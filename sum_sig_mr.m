function sum_w = sum_sig_mr(sigma, mx, i, j)
[m,n] = size(sigma);

if(((mx+i-1)==1)&&(j==1))
    sum_w = sigma(mx+i-1,j+1) + sigma(mx+i,j);
elseif(((mx+i-1)==1)&&(j==n))
    sum_w = sigma(mx+i-1,j-1) + sigma(mx+i,j);
elseif(((mx+i-1)==1)&&(j>1))
    sum_w = sigma(mx+i-1,j-1) + sigma(mx+i-1,j+1) + sigma(mx+i,j);
elseif(((mx+i-1)==m)&&(j==1))
    sum_w = sigma(mx+i-1,j+1) + sigma(mx+i-2,j);
elseif(((mx+i-1)==m)&&(j==n))
    sum_w = sigma(mx+i-1,j-1) + sigma(mx+i-2,j);
elseif(((mx+i-1)==m)&&(j>1))
    sum_w = sigma(mx+i-1,j-1) + sigma(mx+i-1,j+1) + sigma(mx+i-2,j);
elseif(((mx+i-1)>1)&&(j==1))
    sum_w = sigma(mx+i-1,j+1) + sigma(mx+i-2,j) + sigma(mx+i,j);
elseif(((mx+i-1)>1)&&(j==n))
    sum_w = sigma(mx+i-1,j-1) + sigma(mx+i-2,j) + sigma(mx+i,j);
else
    sum_w = sigma(mx+i-1,j-1) + sigma(mx+i-1,j+1) + sigma(mx+i-2,j) + sigma(mx+i,j);
end
end