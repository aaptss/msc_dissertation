function outputData = allElectrodeDataImport(firstElec, lastElec, pathToFiles)
% function provides cell array with all the .txt files imported.
% the output is outputData{positiveIelectrode, negativeIelectrode}
%
% inputs : 
% firstElec - ID of the first electrode
% lastElec - ID of the last electrode
% pathToFiles - directory with files contained
%
% outputs:
% outputData - n-by-n cell array where n is amount of electrodes. 
% outpitData is configuredin such a way what every column represents the
% positive current electrode ordinal, and every row represents the 
% negative current electrode ordinal number

outputData = cell(32);

for i = firstElec : lastElec
    if i < 10
        preamb = "inj0";
    else
        preamb = "inj";
    end
    
    for j = firstElec : lastElec
        if j < 10
            delim = "_0";
        else
            delim = "_";
        end
        flname = strcat(pathToFiles, preamb, num2str(i), delim, num2str(j), ".txt");
        if isfile(flname)
            outputData{i,j} = initialDataImport(flname);
        else
        end
    end
end
end