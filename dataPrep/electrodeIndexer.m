function potData = electrodeIndexer(croppedData, mp)
% function electrodeIndexer evaluates the potential value for each of
% electrodes. The input must be previously cropped data
%
% croppedData - cropped cell array of values imported from comsol
% mp - model parameters 
%
% potData - cropped cell array of values with potential electrode indexes
potData = cell(size(croppedData));

electrodeAngle =  acos ( -( (2 * mp.elecRad) ^ 2 - 2 * mp.thorR ^ 2) / ( 2 * mp.thorR ^ 2 )); %law of cosines
electrodeGap = (2 * pi / 32) - electrodeAngle;

    for i = mp.elecFirst : mp.elecLast
        for j = mp.elecFirst : mp.elecLast
            if ~isempty(croppedData{i,j})
                potData{i,j} = sortrows(croppedData{i,j}, 'theta');

                potData{i,j}.dtheta = potData{i,j}.theta;
                  
                dtheta = diff(potData{i,j}.dtheta); 
                dtheta(size(potData{i,j}.dtheta)) = 0;
                  
                potData{i,j}.dtheta = dtheta;
                
                ind = 1;
                for k = 1:1:numel(potData{i,j}.theta)
                    if potData{i,j}.dtheta(k) < electrodeGap
                        potData{i,j}.index(k) = ind;
                    else
                        potData{i,j}.index(k) = ind;
                        ind = ind + 1;
                        if ind > mp.elecLast
                            ind = mp.elecFirst;
                        end
                    end
                end % for k = 1:1:numel(pot_data{i,j}.theta)
            end % ~isempty(croppedData{i,j})
        end % j = modelParameters.elecFirst : modelParameters.elecLast
    end % i = modelParameters.elecFirst : modelParameters.elecLast
end