function [matrice2] = river(SizeWorld,matrice)
World_river = zeros(SizeWorld*3);
for i = 1:randi(floor(SizeWorld/23))
    River_First_x = randi([SizeWorld,SizeWorld*2],1,1);
    River_First_y = randi([SizeWorld,SizeWorld*2],1,1);
    World_river(River_First_x-1:River_First_x+1,River_First_y-1:River_First_y+1) = 10;
    World_river(River_First_x-2:River_First_x+2,River_First_y) = 10;
    World_river(River_First_x,River_First_y-2:River_First_y+2) = 10;
    for k=1:SizeWorld*15
        switch(randi(4))
            case 1
                River_First_x = River_First_x + randi(2);
            case 2
                River_First_x = River_First_x - randi(2);
            case 3
                River_First_y = River_First_y + randi(2);
            case 4
                River_First_y = River_First_y - randi(2);
        end
    
    World_river(River_First_x-1:River_First_x+1,River_First_y-1:River_First_y+1) = 10;
    World_river(River_First_x-2:River_First_x+2,River_First_y) = 10;
    World_river(River_First_x,River_First_y-2:River_First_y+2) = 10;
    end
end
matrice2 = World_river(SizeWorld:SizeWorld*2-1,SizeWorld:SizeWorld*2-1);
matrice2 = matrice + matrice2;
matrice2 = matrice2 - (matrice2==11);
matrice2(1:size(matrice2),1) = 0;
matrice2(1:size(matrice2),size(matrice2)) = 0;
matrice2(1,1:size(matrice2)) = 0;
matrice2(size(matrice2),1:size(matrice2)) = 0;
end
