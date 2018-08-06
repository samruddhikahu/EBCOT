function [Atmp, CX, D, sigp] = MR_pass_decode(Atmp, CX, D, sigma, eta, sigp, bit_plane, mx)
p = 0;
n = size(Atmp,2);
for j = 1:n
    for i = 1:4
        if((sigma(mx+i-1,j)==1)&&(eta(mx+i-1,j)==0))
            p = p + 1;
            dbit = str2num(D(p));
            if(Atmp(i,j)>0)
                Atmp(i,j) = Atmp(i,j) + (dbit*(2^bit_plane));
            else
                Atmp(i,j) = Atmp(i,j) - (dbit*(2^bit_plane));
            end
            sigp(mx+i-1,j)=1;
        end
    end
end
CX(1:p) = [];
D(1:p) = '';
end