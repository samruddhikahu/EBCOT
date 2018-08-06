function [CX, D, sigma, eta] = SP_pass(Atmp, mx, sigma, chi, bit_plane, CX, D, subband)
eta = zeros(size(sigma));
n = size(Atmp,2);

for j = 1:n
    for i = 1:4
        w = func_sig1(sigma,mx,i,j);
        if((sigma(mx+i-1,j)==0)&&sum(sum(w))>0)
            % Zero Coding of the current coefficient;
            C = dec2bin(abs(Atmp(i,j)),bit_plane+1);
            
            if(subband=='1') % LH and LL sub-bands.
                [CX, D] = zero_coding_LHLL(C,sigma,CX,D,mx,i,j);
            elseif(subband=='2') % HL sub-band.
                [CX, D] = zero_coding_HL(C,sigma,CX,D,mx,i,j);
            elseif(subband=='3') % HH sub-band.
                [CX, D] = zero_coding_HH(C,sigma,CX,D,mx,i,j);
            end
            
            eta(mx+i-1,j) = 1;
            %if the coded coefficient has bit value 1, encode its sign.
            if(C(1)=='1')
                % Sign Coding;
                [CX, D] = sign_coding(chi,sigma,CX,D,mx,i,j);
                sigma(mx+i-1,j) = 1;
            end
        end
    end
end

end