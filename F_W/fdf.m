SizW = 155;
riverON = true;
WindON = true;
graphs = false;
ForestData = zeros(100,3);
ForestData(:,2)=(1:100).';
if input('See fire ? [Y/N] ','s') == 'Y'
    graphs = true;
    until = 1;
    untilIT = false;
    density = input('Density ? ]0,1]');
else
    if input('Study ? [Y/N] ','s') == 'Y'
        until = 100;
        untilIT = true;
    end
end
if graphs
    colormap([1,1,1;0.1961,0.8039,0.1961;0.4,0.4,0.4;0.9,0,0])
end

for n = 1:until
    if untilIT
        untilIT = n/100;
    else
        untilIT = density;
    end
    World = zeros(SizW+2);
    World(2:SizW+1,2:SizW+1) = rand(SizW)<untilIT;
    boot = randi([1,size(World,2)],1,2);
    Forest = 0;
    
    if rand(1,1)<1 && riverON
        if graphs
            colormap([1,1,1;0.1961,0.8039,0.1961;0.4,0.4,0.4;0.9,0,0;0,0.3,0;0,0.3,0;0,0.3,0;0,0.3,0;0,0.3,0;0,0,1])
        end
        river = randi([3,SizW-1],1,1);
        for i = 2:SizW+1
            World(i,randi([river-2,river-1],1,1):randi([river+1,river+2],1,1)) = 10;
            if river == SizW-1
                if rand(1,1) < 0.5
                    river = river -1;
                end
            elseif river == 3
                if rand(1,1) < 0.5
                river = river + 1;
                end
            else
                if rand(1,1) > 0.75
                    river = river + 1;
                elseif rand(1,1) < 0.25
                    river = river - 1;
                end
            end
        end
    end
    
    
    
    GhostWorld = World;
    
    if WindON == true
        Wind = randi([-2,2],1,1);
    else
        Wind = 0;
    end
    
    while World(boot(1,1),boot(1,2)) ~= 1
        boot = randi([1,size(World,2)],1,2);
    end
    World(boot(1,1),boot(1,2))=3;
    
    while true
        if Forest==0
            Forest = sum(World==1,'all');
        end
        if WindON == true
            if rand(1,1)<0.03
                if 1 == norm(Wind)
                    Wind = randi([-1,1],1,1)*2;
                elseif 2 == norm(Wind)
                    Wind = randi([-1,1],1,1);
                else
                    Wind = randi([-2,2],1,1);
                end
            end
        end
        for j = 2 : size(World,2)-1
            for i = 2 : size(World,1)-1
                if World(i,j) == 3
                    switch norm(Wind)
                        case 0
                            if World(i+1,j) == 1
                                GhostWorld(i+1,j) = 3;
                            end
                            if World(i-1,j) == 1
                                GhostWorld(i-1,j) = 3;
                            end
                            if World(i,j+1) == 1
                                GhostWorld(i,j+1) = 3;
                            end
                            if World(i,j-1) == 1
                                GhostWorld(i,j-1) = 3;
                            end
                        case 1
                            if World(i+(1*Wind),j) == 1
                                GhostWorld(i+(1*Wind),j) = 3;
                            end
                            if World(i+(1*Wind),j-1) == 1
                                GhostWorld(i+(1*Wind),j-1) = 3;
                            end
                            if World(i+(1*Wind),j+1) == 1
                                GhostWorld(i+(1*Wind),j+1) = 3;
                            end
                        case 2
                            if World(i,j+(1*(Wind/2))) == 1
                                GhostWorld(i,j+(1*(Wind/2))) = 3;
                            end
                            if World(i-1,j+(1*(Wind/2))) == 1
                                GhostWorld(i-1,j+(1*(Wind/2))) = 3;
                            end
                            if World(i+1,j+(1*(Wind/2))) == 1
                                GhostWorld(i+1,j+(1*(Wind/2))) = 3;
                            end
                    end
                    GhostWorld(i,j) = 2;
                end
            end
        end
        World = GhostWorld;
        if graphs
            if sum((World-3)==0)==0
                if sum((World-10)==0,'all')== 0
                    colormap([1,1,1;0.1961,0.8039,0.1961;0.4,0.4,0.4])
                    pcolor(World(2:SizW+1,2:SizW+1))
                end
            end
        end
        if graphs
            pcolor(World(2:SizW+1,2:SizW+1))
            drawnow;
        end
        if sum((World-3)==0)==0
            break
        end
    end
    inst = sum(World==2,'all')/Forest;
    ForestData(n,1) = inst;
end