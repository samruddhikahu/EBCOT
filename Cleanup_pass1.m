function [sigma, CX, D] = Cleanup_pass1(Atmp, mx, sigma, chi, eta, bit_plane, CX, D, subband)

n = size(Atmp,2);
%if(~exist('D'))
%    p = 1;
%else
%p = length(D)+1;
%end
for j = 1:n
    clear Idx;
    i = 1;
    while(i<=4)
        if((sigma(mx+i-1,j)==0)&&(eta(mx+i-1,j)==0))  % Encode the current position only if sigma and eta are zero at it.
            w = func_sig(sigma,mx,i,j);
            Cj = Atmp(:,j)';
            if((i==1)&&(sum(sum(w))==0))
                % Enable RLC mode;
                %Cj = Atmp(:,j)';
                if(max(abs(Cj))>=(2^bit_plane))
                    % Output 1 in RL mode and start ZC mode;
                    p = length(D)+1;
                    D(p) = '1';
                    CX(p) = 17;
                    %p = p + 1;
                    % Find out the entries in Cj with values greater than 2^bit_plane;
                    Idx = find(abs(Cj)>=(2^bit_plane));
                    dCj = dec2bin(Idx(1)-1,2);
                    p = length(D)+1;
                    CX(p) = 18;
                    D(p) = dCj(1);
                    p = p + 1;
                    CX(p) = 18;
                    D(p) = dCj(2);
                    sigma(mx+Idx(1)-1,j) = 1;
                    % Then go for Sign Coding of this index value;
                    [CX, D] = sign_coding(chi,sigma,CX,D,mx,Idx(1),j);
                    i = Idx(1)+1;
                else
                    p = length(D)+1;
                    D(p) = '0';
                    CX(p) = 17;
                    %p = p + 1;
                    %i = 4;
                    i = i + 4;
                    %continue;
                end
            else
                % Enable ZC mode;
                %Cj = Atmp(:,j)';
                %for k = i:4
                C = dec2bin(abs(Cj(i)),bit_plane+1);
                if(subband=='1') % LH and LL sub-bands.
                    [CX, D] = zero_coding_LHLL(C,sigma,CX,D,mx,i,j);
                elseif(subband=='2') % HL sub-band.
                    [CX, D] = zero_coding_HL(C,sigma,CX,D,mx,i,j);
                elseif(subband=='3') % HH sub-band.
                    [CX, D] = zero_coding_HH(C,sigma,CX,D,mx,i,j);
                end
                %p = p + 1;
                if(C(1)=='1')
                    sigma(mx+i-1,j) = 1;
                    % Go for sign coding:-
                    [CX, D] = sign_coding(chi,sigma,CX,D,mx,i,j);
                end
                i = i + 1;
                %end
            end
        else
            i = i + 1;
        end
        
    end
end

end