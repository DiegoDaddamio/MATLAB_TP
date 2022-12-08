SizW = 50;
World = zeros(SizW+2);
World(2:SizW+1,2:SizW+1) = rand(SizW)<0.6;
hold on
spy(World,'g')
boot = randi([1,size(World,2)],1,2);
while World(boot(1,1),boot(1,2)) ~= 1
    boot = randi([1,size(World,2)],1,2);
end
World(boot(1,1),boot(1,2))=3;

while true
    for j = 1 : size(World,2)
        for i = 1 : size(World,1)
            if World(i,j) == 3
                if World(i+1,j) == 1
                    World(i+1,j) = 3;
                end
                if World(i-1,j) == 1
                    World(i-1,j) = 3;
                end
                if World(i,j+1) == 1
                    World(i,j+1) = 3;
                end
                if World(i,j-1) == 1
                    World(i,j-1) = 3;
                end
                World(i,j) = 2;
            end
        end
    end
    spy((World-3)==0,'red')
    spy((World-2)==0,'black')
    drawnow;
    if sum((World-3)==0)==0
        break
    end
end