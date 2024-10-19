function result = REDCap_write(conn, data);
% REDCap_write - Import records
%
% Arguments:
% - conn: REDCAP API connection
% - data: 1xn array of structures specifying the values to be imported 
%   for each record
%
% Value:
% - The function returns a count of records that have been affected
%
% Details:
%
% - The data array should have one row and one column for each structure. 
% - The format of the structure(s) in the data array is:
%
%    struct('record', <record_id>, ...                                   % integer
%           'event', '<redcap_event_name>',                              % (only for longitudinal projects)
%           'field', ["<field_name>" "<field_name>" "<field_name>"], ... % array of strings
%           'value', ["<value>"       "<value>"      "<value>"] ...      % array of strings
%       )
%
% - The 'field' and 'value' arrays should have the same size.
% - The 'event' is needed only for longitudinal projects.  
%

% convert data argument in json format
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
    'type','flat', ...
    'overwriteBehavior','overwrite ', ... % overwrite
    'forceAutoNumber','false',...
    'data',data_json, ...
    'returnContent','count', ...
    'returnFormat','csv', ops);

end

