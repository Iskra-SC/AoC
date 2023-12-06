fid=fopen('day3.txt');
lnum = 1;
while ~feof(fid)
    line = fgetl(fid);
    lineStr(lnum).symx = regexp(line, "[^.1234567890]");
    lineStr(lnum).gearx = regexp(line, '*');
    lineStr(lnum).gear = [];
    lineStr(lnum).num = extract(line, digitsPattern()); %Get digits
    digits = strfind(line, digitsPattern()); %Find index of digits
    if ~isempty(digits)
        lineStr(lnum).numx = digits([true, diff(digits)~=1]); %Cull consec.
    end
    lnum=lnum+1;
end
Score1=[];
for k = 1:length(lineStr)
    for l = 1:length(lineStr(k).num)
        Scorediff=Score1;
        nx = lineStr(k).numx(l);
        n = double(string(lineStr(k).num(l)));
        a = max(lineStr(max(k-1, 1)).symx - 1, 1);
        b = min(lineStr(max(k-1, 1)).symx + 1, length(line));
        c = max(lineStr(k).symx - 1, 1);
        d = min(lineStr(k).symx + 1, length(line));
        e = max(lineStr(min(k+1, length(lineStr))).symx - 1, 1);
        f = min(lineStr(min(k+1, length(lineStr))).symx + 1, length(line));        
        if sum((nx+length(char(lineStr(k).num(l)))>a) & nx<=b)
            Score1 = [Score1  n];
        elseif sum((nx+length(char(lineStr(k).num(l)))>c) & nx<=d)
              Score1 = [Score1  n];
        elseif k<length(lineStr) && ...
            sum((nx+length(char(lineStr(k).num(l)))>e) & nx<=f)
                Score1 = [Score1  n];
        end      
    end
end
Score2=0;
for k = 1:length(lineStr)
    for l=1:length(lineStr(k).gearx)
        gearMultipliers = [];
        for m = 1:length(lineStr(k).numx)
            if (lineStr(k).gearx(l) >= (lineStr(k).numx(m) - 1)) && ...
                    (lineStr(k).gearx(l) <= (lineStr(k).numx(m) + ...
                    length(char(lineStr(k).num(m)))))
                gearMultipliers = [gearMultipliers lineStr(k).num(m)];
            end
        end
        if k>1
            for m = 1:length(lineStr(k-1).numx)
                if (lineStr(k).gearx(l) >= (lineStr(k-1).numx(m) - 1)) &&...
                        (lineStr(k).gearx(l) <= (lineStr(k-1).numx(m) + ...
                        length(char(lineStr(k-1).num(m)))))
                gearMultipliers = [gearMultipliers lineStr(k-1).num(m)];
                end
            end   
        end
        if k<length(lineStr)
            for m = 1:length(lineStr(k+1).numx)
                if (lineStr(k).gearx(l) >= (lineStr(k+1).numx(m) - 1)) &&...
                        (lineStr(k).gearx(l) <= (lineStr(k+1).numx(m) + ...
                        length(char(lineStr(k+1).num(m)))))
                gearMultipliers = [gearMultipliers lineStr(k+1).num(m)];
                end
            end
        end
        if numel(gearMultipliers)==2
            Score2=Score2 + prod(double(string(gearMultipliers)), "all");
        end
    end
end
disp(['Task 1: ', num2str(sum(Score1))])
disp(['Task 2: ', num2str(Score2)])
fclose(fid);