money_pocket = 25;
game_on = true;
while game_on
    while true
        dice_deal = input("Dice deal ? ");
        if floor(dice_deal) == dice_deal
            if dice_deal<7
                if dice_deal>0
                    break
                end
            end
        end
    end
    
    while true
        money_deal = input("Money deal ? ");
        if floor(money_deal) == money_deal
            if money_deal<=money_pocket
                if money_deal>0
                    break
                end
            end
        end
    end
    
    dice = randi(6,1,3);
    disp("Dice reveal :")
    fprintf("%d\n",dice)
    
    switch sum(dice == dice_deal)
        case 0
            money_pocket = money_pocket - money_deal;
        case 1
            money_pocket = money_pocket + money_deal;
        case 2
            money_pocket = money_pocket + 2*money_deal;
        case 3
            money_pocket = money_pocket + 10*money_deal;
    end
    fprintf("Money left : %d$",money_pocket); disp(" ");
    if money_pocket<=5
        disp("Sorry, you don't have enough money to play again...")
        game_on = false;
    end
    if money_pocket>=100
        disp("You have too much money, the dealer will not be able to change")
        game_on = false;
    end
    if game_on
        if upper(input("Continue (y/n) ? ","s")) == "N"
            game_on = false;
        end
    end
end