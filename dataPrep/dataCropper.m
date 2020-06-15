function cropped = dataCropper(initData, modelParameters)
% function returns the dataset without data for any point which is not on an
% electrode.
cropped = cell(size(initData));
    for i = modelParameters.elecFirst : modelParameters.elecLast
        for j = modelParameters.elecFirst : modelParameters.elecLast
            if isempty(initData{i,j})
            else
                cropped{i,j} = initData{i,j}(initData{i,j}.rho > modelParameters.thorR * 1,:);
            end
        end
    end
    
end