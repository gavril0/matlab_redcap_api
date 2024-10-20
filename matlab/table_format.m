function result = table_format(tbl, format)
% table_format  convert table columns containing a cell array  
% Arguments:
% - tbl: table
% - format: string specifying the form conversion. The possible values are: 
%   - 'cell2string': convert cell arrays into arrays of strings
%   - 'cell2char': convert cell arrays into arrays of character vectors
%   - 'none': no conversion
    result = tbl;
    for name = string(tbl.Properties.VariableNames)
       %  disp(name)
        switch format
            case  'cell2string'  
                % convert cell array into string array
                if strcmp(class(tbl.(name)), 'cell')
                    result.(name) = string(tbl{:,name});
                end
            case 'cell2char'
                % convert cell array into character vector
                if strcmp(class(tbl.(name)), 'cell')
                    result.(name) = char(stringtbl{:,name});
                end       
            case 'none'
            case 'otherwise'
        end
    end % for
end