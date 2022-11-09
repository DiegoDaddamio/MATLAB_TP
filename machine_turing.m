disk = char("++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.");
memory = zeros(1,10);
where = 1;
play = true;
boucle = zeros(2);
k = 1;

for n = 1:size(disk,2)
    if disk(n) == "["
        boucle(k,1) = n;
        count = 0;
        for m = n+1:size(disk,2)
            if disk(m) == "["
                count = count + 1;
            elseif disk(m) == "]"
                if count == 0
                    boucle(k,2) = m;
                    break
                else
                    count = count - 1;
                end
            end
        end
        k = k + 1;
    end
end


n = 0;
while play
    n = n + 1;
    switch disk(n)
        case "<"
            where = where - 1;
        case ">"
            where = where + 1;
        case "+"
            memory(where) = memory(where) + 1;
        case "-"
            memory(where) = memory(where) - 1;
        case "."
            disp(char(memory(where)))
        case "]"
            if memory(where) ~= 0
                for l = 1:size(boucle,1)
                    if n == boucle(l,2)
                        n = boucle(l,1);
                        break
                    end
                end
            end
    end
    if n == size(disk,2)
        play = false;
    end
end