fid=fopen('day2.txt');
while ~feof(fid)
    line = fgetl(fid);
    id=double(string(extractBetween(line, "Game ", ":")));    
    Game(id).id=id;
    sets = split(extractAfter(line, ":"), ";");
    for k=1:length(sets)
        pat = digitsPattern() + " red";
        Game(id).set(k).red=sum(double(string(extract(extract(sets(k),...
            pat), digitsPattern()))));
        pat = digitsPattern() + " green";
        Game(id).set(k).green=sum(double(string(extract(extract(sets(k),...
            pat), digitsPattern()))));
        pat = digitsPattern() + " blue";
        Game(id).set(k).blue=sum(double(string(extract(extract(sets(k),...
            pat), digitsPattern()))));        
    end
end
[Score1 Score2] = deal(0);
for k=[Game.id]
    Score1 = Score1 + k * ((max([Game(k).set.blue]) <= 14) & ...
        (max([Game(k).set.green]) <= 13) & (max([Game(k).set.red]) <= 12));
    Score2 = Score2 + max([Game(k).set.red])*max([Game(k).set.blue]) * ...
        max([Game(k).set.green]);
end
disp(['Task 1: ', num2str(Score1)])
disp(['Task 2: ', num2str(Score2)])
fclose(fid);
