function modified_case_library = cbrTP()
    opts = detectImportOptions("Train.csv");
    opts.DataLines = 2;
    opts.VariableTypes = {'int32', 'int32', 'string', 'string', 'int32', 'string', 'string', 'string', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'double'};
    case_library = readtable("Train.csv", opts);
    modified_case_library = retrieveTP(case_library);
    disp(modified_case_library);
end

