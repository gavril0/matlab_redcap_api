% redcap_events - read events
%
% Syntax
% ------
% result = redcap_events(conn)
% 
% Description
% -----------
% `redcap_events` returns a table with the events:
% - `conn`: REDCap connection handle (see `redcap_connection`)
%
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function result = redcap_events(conn)
    ops = weboptions('CertificateFilename', '', 'Debug', false);
    result = webwrite(conn.url, 'token', conn.token, ...
        'content','event', 'format','csv', 'type','flat', ...
        'rawOrLabel','raw', 'rawOrLabelHeaders','raw', 'exportCheckboxLabel','false', ...
        'exportSurveyFields','false', 'exportDataAccessGroups','false', 'returnFormat','csv', ops);
    result = table_format(result, conn.table_format);    
end