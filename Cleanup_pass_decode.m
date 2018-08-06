function [Atmp, sigma, chi, CX, D] = Cleanup_pass_decode(Atmp, CX, D, sigma, chi, eta, bit_plane, mx)

n = size(sigma,2);
p = 1;
%Atmp = zeros(4,n);
for j = 1:n
    clear idx;
    i = 1;
    Cj = Atmp(:,j);
    while(i<=4)
        if((sigma(mx+i-1,j)==0)&&(eta(mx+i-1,j)==0)) % Decode the current position if sigma and eta are zero;
            if(CX(p)==17)
                % CUP is in RLC mode;
                if(D(p)=='1')
                    % There is atleast 1 1bit in the current row;
                    % Get the next two bits for 1bit position;
                    p = p + 1;
                    dpos = D(p:p+1);
                    idx = bin2dec(dpos);
                    sigma(mx+idx,j) = 1;
                    p = p + 2;
                    % Sign decoding;
                    [s, chi] = sign_decoding(sigma,chi,CX,D,p,mx,idx+1,j);
                    Cj(idx+1,1) = s*(2^bit_plane);
                    p = p + 1;
                    i = idx + 2;
                else
                    p = p + 1;
                    i = i + 4;
                    %i = 4;
                    %break;
                end
            else
                % CUP is in zero coding mode;
                %Cj = Zero_decoding(sigma, CX, D, mx, i, j, p, bit_plane);
                if(D(p)=='1')
                    sigma(mx+i-1,j)=1;
                    % Go for sign decoding;
                    p = p + 1;
                    [s, chi] = sign_decoding(sigma,chi,CX,D,p,mx,i,j);
                    Cj(i,1) = s*(2^bit_plane);
                    %p = p + 1;
                end
                p = p + 1;
                i = i + 1;    
            end
            % p = p + 1; 
        else
            i = i + 1;
        end
    end
    Atmp(:,j) = Cj;
end
CX(1:p-1) = [];
D(1:p-1) = '';
end