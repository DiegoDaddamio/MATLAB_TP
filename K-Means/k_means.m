% K-Means D. D'A. 20221950

Data = importdata('K_Means_Data_Base.xlsx');
Data = Data.data;
DataSize = size(Data,1);
Cmax = 4;
Ite = 0;
visual = 0;
ClustMoveX = zeros(Cmax,1);
ClustMoveY = zeros(Cmax,1);
Cluster = [0,0];
elbow = [0,0];
Norm = [0;0]; 
Groupe = [0;0];


for c = 1 : Cmax
    Cluster(c,:) = rand(1,2)*100;
    again = true;
    
    while again
        Tester = Cluster;
        if c == Cmax
            Ite = Ite + 1;        
            ClustMoveX(:,Ite) = Cluster(:,1);
            ClustMoveY(:,Ite) = Cluster(:,2);
        end
        for i = 1:DataSize
            point = Data(i,:);

            for j = 1:c
                Norm(i,j) = norm(point-Cluster(j,:));
            end
            minimum = min(Norm(i,:));
            Norm(i,:) = (Norm(i,:) == minimum)*minimum;
        end 
        for j = 1:c
            bary = [0,0];
            count = 0;
            for i = 1:DataSize
                if Norm(i,j) ~= 0
                    bary = bary + Data(i,:);
                    count = count + 1;
                end
                if c == Cmax && Norm(i,j) > 0
                    Groupe(i,1) = j;
                end
            end
            if count ~= 0
                Cluster(j,:) = bary/count;
            else
                Cluster(j,:) = rand(1,2)*100;
            end
        end
        if Tester == Cluster
            again = false;
        end
    end

    elbow(c,:) = [c,sum(Norm.^2,'all')];

end
if visual
    figure('Name','Déplacement','NumberTitle','off');
    hold on
    scatter(Data(:,1),Data(:,2),"blue","filled")
    scatter(ClustMoveX,ClustMoveY,"green","filled")
    scatter(Cluster(:,1),Cluster(:,2),"red","filled")
    figure('Name','Elbow Method','NumberTitle','off');
    scatter(elbow(:,1),elbow(:,2),"filled")
    color = rand(Cmax,3);
    figure('Name','Groupe','NumberTitle','off');
    hold on
    for i = 1 : Cmax
        Scax = [0;0];
        Scay = [0;0];
        count = 0;
        for j = 1 : DataSize
            if Groupe(j,1) == i
                count = count + 1;
                Scax(count,1) = Data(j,1);
                Scay(count,1) = Data(j,2);
            end
        end
        scatter(Scax,Scay,[],color(i,:),'filled')
    end
end

for i = 1 : size(elbow,1)
    if ((elbow(i,2)/sum(elbow(:,2)))*100) < 5
        fprintf("Le nombre de cluster adéquat serait %d",i-1)
        break
    end
end
