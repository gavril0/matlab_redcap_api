function result = REDCap_events(conn)
% REDCap_events Read events
% Parameters:
%    conn: REDCap connection structure
% Value:
%    Table with events
    ops = weboptions('CertificateFilename', '', 'Debug', false);
    result = webwrite(conn.url, 'token', conn.token, ...
        'content','event', 'format','csv', 'type','flat', ...
        'rawOrLabel','raw', 'rawOrLabelHeaders','raw', 'exportCheckboxLabel','false', ...
        'exportSurveyFields','false', 'exportDataAccessGroups','false', 'returnFormat','csv', ops);
    result = table_format(result, conn.table_format);    
end