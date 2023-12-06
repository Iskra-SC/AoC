tic
fid=fopen('day5.txt');
line = fgetl(fid);
seed=double(string(split(extractAfter(line, "seeds: "), " ")));
seedRange=[seed(1:2:end), seed(1:2:end)+seed(2:2:end)-1];
while ~feof(fid)
   line = fgetl(fid);
   switch line
       case "seed-to-soil map:"
	   seedToSoil = map(fid);
       case "soil-to-fertilizer map:"
           soilToFertilizer = map(fid);
       case "fertilizer-to-water map:"
    	   fertilizerToWater = map(fid);
       case "water-to-light map:"
           waterToLight = map(fid);
       case "light-to-temperature map:"
	   lightToTemp = map(fid);
       case "temperature-to-humidity map:"
	   tempToHumidity = map(fid);
       case "humidity-to-location map:"
	   humidityToLocation = map(fid);
   end
end
fclose(fid);
Score1 = min(mapFind(humidityToLocation, ...
    mapFind(tempToHumidity, ...
    mapFind(lightToTemp, ...
    mapFind(waterToLight, ...
    mapFind(fertilizerToWater, ...
    mapFind(soilToFertilizer, ...
    mapFind(seedToSoil, seed))))))));
Score2 = min(min(mapFindRange(humidityToLocation, ...
    mapFindRange(tempToHumidity, ...
    mapFindRange(lightToTemp, ...
    mapFindRange(waterToLight, ...
    mapFindRange(fertilizerToWater, ...
    mapFindRange(soilToFertilizer, ...
    mapFindRange(seedToSoil, seedRange)))))))));
disp(['Task 1: ', num2str(Score1)])
disp(['Task 2: ', num2str(Score2)])
toc
function y = map(fid)
    y=[];
    line = fgetl(fid);
    while ~isempty(line) && ~feof(fid)
        y = [y; double(string(split(line, " ")))'];
        line = fgetl(fid);
    end
end
function y = mapFind(map, x)
y = [];	
    for k = reshape(x, 1, [])
        row=find(map(:, 2)<=k & map(:, 2)+map(:, 3)>k);
	if isempty(row)
	    y = [y k];
	else
            y = [y map(row, 1) + k - map(row, 2)];   
	end
    end
end
function y = mapFindRange(map, x)
y = [];	
    for k = 1:length(map(:, 1))
	for l = 1:length(x(:, 1))
	    if ~isnan(x(l, :))
	        if x(l,2) >= map(k, 2) && x(l,1) < map(k, 2) +  map(k, 3)
		    y = [y; [max(x(l, 1), map(k, 2)) min(map(k, 2) +  ...
			map(k, 3)- 1, x(l, 2))] - diff([map(k, 1) ...
			map(k, 2)])];    
	        end
	        if x(l,1) < map(k, 2)
		    x = [x; [x(l,1) min(map(k, 2) -1,  x(l,2)) ]];
	        end
	        if x(l,2) >= map(k, 2) + map(k, 3)
		    x = [x; [max(map(k, 2) + map(k, 3),  x(l,1)) x(l,2)]];
	        end
	        x(l, :) = [NaN, NaN];
	    end
	end
    end
y = [y; [x(x(:, 1)>=0, 1) x(x(:, 2)>=0, 2)]];
end
