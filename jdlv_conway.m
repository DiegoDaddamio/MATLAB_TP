N=100;
N = N + 1;
M = randi([0,1],N);
%M = rand(N,N)>0.8 "dillution de proba"
M(:,1)=0;
M(:,N)=0;
M(N,:)=0;
M(1,:)=0;
G = M;

for o = 1:1000000
    spy(M)
    for i = 1:N-2
        for j = 1:N-2
            k = sum(sum(M(i:2+i,j:2+j)));
            if M(i+1,j+1) == 1
                k = k-1;
            end
            if k == 3
                G(i+1,j+1) = 1;
            elseif k == 2
                G(i+1,j+1) = M(i+1,j+1);
            else
                G(i+1,j+1) = 0;
            end 
        end
    end
    spy(M); drawnow
    M = G;
end

