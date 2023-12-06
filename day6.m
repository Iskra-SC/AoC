fid=fopen('day6.txt');
%%Task 1
timeLimit=double(string(extract(fgetl(fid), digitsPattern())))';
recordDistance=double(string(extract(fgetl(fid), digitsPattern())))';
Score1 = [];
for k = 1:length(timeLimit)
Score1 = [Score1 winPressTimeNo(timeLimit(k), recordDistance(k))];
end
Score1 = prod(Score1);

%% Task 2
timeLimit = double(strrep(join(string(timeLimit)),' ',''));
recordDistance = double(strrep(join(string(recordDistance)),' ',''));
Score2 = winPressTimeNo(timeLimit, recordDistance);
disp(['Task 1: ', num2str(Score1)])
disp(['Task 2: ', num2str(Score2)])

function n = winPressTimeNo(a, b)
% Computes the max and min press time using the pq formula
    minPressTime = ceil((a/2-sqrt(a^2/2^2-b)));
    maxPressTime = floor((a/2+sqrt(a^2/2^2-b)));
    c = ((a-minPressTime) * minPressTime > b) + ...
        ((a-maxPressTime) * maxPressTime > b);
    n = (maxPressTime - minPressTime + c - 1);
end