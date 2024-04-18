close all; clear; clc;

data = load("data_segmentttt.mat");
data = % nazev datoveho souboru;

zeroGroups = {};
oneGroups = {};

lastSymbol = [];
for index = 1:length(data)
    
    if isempty(lastSymbol) || lastSymbol ~= data(index, 2)
        lastSymbol = data(index, 2);
        if lastSymbol == 0
            zeroGroups{end+1} = [];
        elseif lastSymbol == 1            
            oneGroups{end+1} = [];
        end
    end
    
    switch data(index, 2)
        case 0
            zeroGroups{end}(end+1) = data(index, 1);
        case {1, 2}
            oneGroups{end}(end+1) = data(index, 1);
    end
end

physiological_state=zeroGroups;
stress_state=oneGroups;

save('GSR_all_players_segmentation.mat','stress_state','physiological_state')