function [CX, D, sigp] = MR_pass(Atmp, mx, sigma, eta, sigp, bit_plane_max, bit_plane, CX, D)
n = size(Atmp,2);
for j = 1:n
    for i = 1:4
        if((sigma(mx+i-1,j)==1)&&(eta(mx+i-1,j)==0))
            % MR Coding:
            C = dec2bin(abs(Atmp(i,j)),bit_plane_max);
            p = length(D) + 1;
            D(p) = C(end-bit_plane);
            % Context Coding:-
            if(sigp(mx+i-1,j)==1)
                CX(p) = 16;
            else
                sum_w = sum_sig_mr(sigma,mx,i,j);
                if(sum_w==0)
                    CX(p) = 14;
                else
                    CX(p) = 15;
                end
            end
            sigp(mx+i-1,j)=1;
        end
    end
end
end