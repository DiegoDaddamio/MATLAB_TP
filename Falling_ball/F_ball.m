choice_plate = zeros(21,39);
choice_plate(2:20,20) = 1;
for i = 1:18
    choice_plate(i+2:20,20-i:20+i) = 1;
end

for i = 2:21
    for j = 1:39
        if choice_plate(i-1,j) == 1
            choice_plate(i,j) = 0;
        end
    end
end
choice_plate_patern = choice_plate;

for k = 1:10
    choice_plate = choice_plate_patern;
    hold off
    spy(choice_plate)
    hold on
    BALL_l = 1;
    BALL_c = 20;
    choice_plate(BALL_l,BALL_c) = 2;
    spy(choice_plate == 2,"r")
    
    while true 
        switch choice_plate(BALL_l+1,BALL_c)
            case 1
                BALL_l = BALL_l + 1;
                switch randi([0,1])
                    case 0
                        BALL_c = BALL_c + 1;
                    case 1
                        BALL_c = BALL_c -1;
                end
            choice_plate(BALL_l,BALL_c) = 2;
            spy(choice_plate == 2,"r")
            drawnow;
            case 0
                break
        end
    end
end