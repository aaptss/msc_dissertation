function comsolData = initialDataImport(filename, dataLines)
% function imports and resolves 1 file of comsol's data saved for 1 slice.

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [10, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 7);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["x", "y", "z", "V", "Jx", "Jy", "Jz"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";


% Import the data
comsolData = readtable(filename, opts);
% Add polar coordinates
[comsolData.theta, comsolData.rho] = cart2pol(comsolData.x, comsolData.y);


end