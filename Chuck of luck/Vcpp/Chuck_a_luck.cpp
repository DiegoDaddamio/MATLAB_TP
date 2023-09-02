#include <iostream>
#include <cmath>
#include <conio.h>

int money_pocket = 25;
bool game_on = true;
int dice_deal;
int money_deal;
int counter = 0;

int rollDie()
{
    int roll;
    int min = 1;
    int max = 6;

    roll = rand() % (max) + 1;

    return roll;
}

main(){
    std::cout << "Rules : You have to bet money on a number from 1 to 6."<< std::endl;
    std::cout <<"The dealer rolls 3 dices, if you number is in these 3,"<< std::endl;
    std::cout <<"you will win money in depends on how much you bet and how many dice are there."<< std::endl;
    std::cout <<"If 0 : You lose your bet"<< std::endl;
    std::cout <<"If 1 : You win you bet one time"<< std::endl;
    std::cout <<"If 2 : You win you bet two time"<< std::endl;
    std::cout <<"If 3 : You win you bet ten time"<< std::endl;
    std::cout << "You start with : ";
    std::cout << money_pocket;
    std::cout << " $"<< std::endl;
    while (game_on) {
        while (true) {
            std::cout << "Dice deal ? ";
            std::cin >> dice_deal;
            if (floor(dice_deal)==dice_deal)
            {
                if (dice_deal<7){
                    if(dice_deal>0){
                        break;
                    }
                }
            }
            dice_deal = 0;
        }
        while (true) {
            std::cout << "Money deal ? ";
            std::cin >> money_deal;
            if (floor(money_deal)==money_deal)
            {
                if (money_deal <= money_pocket){
                    if(money_deal>0){
                        break;
                    }
                }
            }
            dice_deal = 0;          
        }
        srand(time(0));
        for(int i=0;i<3;i++)
        {
            int dice_roll = rollDie();
            std::cout << dice_roll << std::endl;
            if (dice_roll == dice_deal){
                counter++;
            }
        }
        switch (counter)
        {
        case 0:
            money_pocket = money_pocket - money_deal;
            break;
        case 1:
            money_pocket = money_pocket + money_deal;
            break;
        case 2:
            money_pocket = money_pocket + 2 * money_deal;
            break;
        case 3:
            money_pocket = money_pocket + 10 * money_deal;
            break;
        }
        counter = 0;
        std::cout << "Money left : ";
        std::cout << money_pocket;
        std::cout << " $"<< std::endl;
        if(money_pocket<=5){
            std::cout <<"Sorry, you don't have enough money to play again..."<< std::endl;
            break;
            game_on = false;
        }
        if(money_pocket>=100){
            std::cout <<"You have too much money, the dealer will not be able to change"<< std::endl;
            break;
            game_on = false;
        }
    }
    std::cout << "Press any key to quit"<< std::endl;
    getch();
    return 0;
}