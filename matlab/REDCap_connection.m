% redcap_connection - Return a handle to connect to REDCAP serve
%
% Syntax
% ------
% handle = REDCap_connection(url, token, longitudinal)
% hanlde = REDCap_connection(url, token, longitudinal, table_format)
%
% Description
% -----------
% `redcap_connection` return a structure to connect to REDCAP server that
% contains the  `url` (character vector) of the REDcap API server 
% and the REDCap API `token` (character vector) for authenticaction. The flag
% `longitudinal` (logical) must indicate if the project is longitudinal or not.
% The optional arguments `table_format` specify the format the of tables returned by 
%  REDCap API functions. The possible value are:
%   - 'cell2string': convert columns with cell array into an array of strings
%   - 'cell2char': convert columns with cell array into an array of character vectors
%   - '': no conversion (default: '').
%
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function result = redcap_connection(url, token, longitudinal, varargin)
    result = struct(url=url, token=token, longitudinal=longitudinal);
    % optional arguments
    keys =    struct(table_format='', web_url='', pid=0);
    argkey = varargin(1:2:end);
    argval = varargin(2:2:end);
    for k = string(fieldnames(keys))'
        if ismember(k, argkey)  
           result.(k) = argval{ismember(argkey,k)};
        else  
           result.(k) = keys.(k); % default value
        end
    end
end

