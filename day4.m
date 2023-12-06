fid=fopen('day4.txt');
Score1=0;
lnum = 0;
Score2 = 1;
while ~feof(fid)
    line = fgetl(fid);
    line = extractAfter(line, ': ');
    lnum = lnum + 1;
    winning = double(string(split(extractBefore(line, " | "), " ")));
    drawn = double(string(split(extractAfter(line, " | "), " ")));
    Score1 = [Score1 floor(2^(numel(intersect(drawn', winning'))-1))];
    if length(Score2)<lnum + max(1, numel(intersect(drawn', winning')))
	Score2(end+1:lnum + max(1, numel(intersect(drawn', winning')))) = 1;
    end
    Score2(lnum+1:lnum + numel(intersect(drawn', winning'))) = ...
	Score2(lnum+1:lnum + numel(intersect(drawn', winning'))) + ...
	Score2(lnum);
    if feof(fid)
	Score2(lnum)=1;
	Score2(lnum+1:end)=[];
    end
end
fclose(fid);
