function result = table_format(tbl, format)
% table_format  format table columns
% Arguments:
% - tbl: table
% - format: 'çell2string'
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
            case 'otherwise'
        end
    end % for
end