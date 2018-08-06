function [Atmp, CX, D, sigma, chi, eta] = SP_pass_decode(Atmp, CX, D, sigma, chi, bit_plane, mx)

eta = zeros(size(sigma));
n = size(Atmp,2);
p = 0;

for j = 1:n
    for i = 1:4
        w = func_sig1(sigma,mx,i,j);
        if((sigma(mx+i-1,j)==0)&&sum(sum(w))>0)
            p = p + 1;
            dbit = D(p);
            eta(mx+i-1,j) = 1;
            if(dbit=='1')
                % Sign Decoding:-
                p = p + 1;
                [s, chi] = sign_decoding(sigma,chi,CX,D,p,mx,i,j);
                Atmp(i,j) = s*(2^bit_plane);
                sigma(mx+i-1,j) = 1;
            end
        end
    end
end
CX(1:p) = [];
D(1:p) = '';
end