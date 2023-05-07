function opts=FSUImporOptionsData()
    % Set up the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 3);
    
    % Specify range and delimiter
    opts.DataLines = [29, Inf];
    opts.Delimiter = ";";
    
    % Specify column names and types
    opts.VariableNames = ["Type", "FSU", "Var3"];
    opts.SelectedVariableNames = ["Type", "FSU"];
    opts.VariableTypes = ["double", "double", "string"];
    
    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % Specify variable properties
    opts = setvaropts(opts, "Var3", "WhitespaceRule", "preserve");
    opts = setvaropts(opts, "Var3", "EmptyFieldRule", "auto");

end