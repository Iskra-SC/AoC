fid=fopen('day1.txt');
sum1 = 0;
sum2 = 0;
while ~feof(fid)
    line = fgetl(fid);
    %% Task 1
    numbers = cell2mat(extract(line,digitsPattern(1)));
    sum1 = sum1 + str2num([numbers(1)  numbers(end)]);

    %% Task2
    numberNames = ["one", "two", "three", "four", "five", "six", ...
        "seven", "eight", "nine"];
    digitTable = []; % Table of digits and their position in the string

    % Add spelled numbers to table
    for name = numberNames
        if contains(line, name) 
            digitTable = [digitTable [strfind(line, name); ...
                ones(1, length(strfind(line, name))) * ...
                find(matches(numberNames, name))]];              
        end
    end

    % Add digits to table
    for index = strfind(line, digitsPattern(1))
        digitTable = [digitTable [index; str2num(line(index))]];
    end

    % Sort the table according to position in string
    [~, I] = sort(digitTable(1, :));
    digitTable=digitTable(:, I);
    sum2 = sum2 + digitTable(2, 1) * 10 + digitTable(2, end);
end
fclose(fid);
disp(['Task 1: ' num2str(sum1)])
disp(['Task 2: ' num2str(sum2)])