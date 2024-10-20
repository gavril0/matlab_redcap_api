% redcap_write - Write record(s) in REDCap database 
%
% Syntax
% -----
% result = redcap_write(conn, data);
% 
% Description
% -----------
% `redcap_write` write records  in REDCap database:
% - `conn`: REDCap connection handle (see `redcap_connection`)
% - `data`: 1D array of structures specifying the values to be imported 
%           for each record
% It returns a count of records that have been affected.
%
% The format of the structure(s) in the data array is:
%
%    struct('record', <record_id>, ...                        % integer
%           'event', '<redcap_event_name>', ...               % (only for longitudinal projects)
%           'field', ["<field_name>" ... "<field_name>"], ... % array of strings
%           'value', ["<value>"      ... "<value>"] ...       % array of strings
%       )
%
% Notes:
% - Record ID should be unique in the array.
% - The field name in each record can correspond to different instruments.
% - The 'field' and 'value' arrays should have the same size.
% - The 'event' is needed only for longitudinal projects.  
% - The date format should be YYYY-MM-DD (e.g. "2024-MM-DD")
%
%  Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function result = redcap_write(conn, data);
% convert data argument in json format string
data_json='[';
for r = data
    r_json = strjoin(strcat('"',r.field,'":"',r.value,'"'),',');
    if(conn.longitudinal)
        r_json=strcat('"redcap_event_name":"',r.event,'",',r_json);
    end
    r_json=strcat('{"record_id":"',num2str(r.record),'",', r_json,'}');
    %
    data_json = strcat(data_json,r_json,',');
end
data_json=char(data_json);
data_json(end)= ']';

ops = weboptions('CertificateFilename', '', 'Debug', false);
result = webwrite(conn.url, 'token', conn.token, ...
    'content','record', ...
    'action','import',...
    'format','json', ...
    'dateFormat', 'YMD', ...
    'type','flat', ...
    'overwriteBehavior','overwrite ', ... % overwrite
    'forceAutoNumber','false',...
    'data',data_json, ...
    'returnContent','count', ...
    'returnFormat','json', ops);
end

