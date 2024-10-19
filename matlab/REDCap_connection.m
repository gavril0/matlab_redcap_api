 
% REDCap_connection - Return a structure to connect to REDCAP server
% 
% result = REDCap_connection(url, token, longitudinal, table_format
% Required arguments:
% - url: URL of REDCAP API server (character vector)
% - token: API token (character vector)
% - web_url: URL of REDCAP web server
% - longitudinal: bolean value
%
% Optional arguments:
% - table_format: format the table returned by REDCap API functions. The
%   possible value are:
%   - 'cell2string': convert columns with cell array into an array of strings
%   - 'cell2char': convert columns with cell array into an array of character vectors
%   - '': no conversion (default: '').
% - web_url: base of the REDCAP web url (everything up to index.php?)
%   (default: '')
% - pid: REDCAP project id (default: 0)
function result = REDCap_connection(url, token, longitudinal, varargin)
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

