% readcap_read - Read records
%
% Syntax
% ------
% result = redcap_read(conn, records, events, fields);
%
% Description
% -----------
% `redcap_read` returns a table with the values of the requested fields, events and records 
% from the database `conn` (see `redcap_connect`). 
% The arguments are:
% - `conn`: REDCap connection handle (see `redcap_connection`)
% - `records`: record IDs (array of integers; [] for all records)
% - `events`: event names  (array of strings, '' for all events)
% - `fields`: field names (array of strings, '' for all fields)
% 
% The format of the table `result` depends on whether the project is longitudinal or not: 
% - For non-longitudinal projects, the table has one row for each record and one column for each field
% - For longitudinal projects, the table has one a row for each event/record combination and a column for each fied.
%   - If two or more events are specified, it will return a row for each combination of events and 
%     records stored in the database
%   - If no events  (events = []) and no records (records=[]) are specified,
%     it will return a table with one row for all combinations of events and 
%     records stored in the database
%   - To avoid results with a lot of "missing" value, it good practice to specify the event(s) 
%     with the fields that corresponds to these events. 
%   - For longitudinal projects, it is not possible to get one row by record with all fields from all events. 
% - The format of the dates in the table is DD-Mon-YYY where Mon is a
%   3-letter abbreviation. This format differs from the one used
%   with 'redcap_write'. 
%
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function result = redcap_read(conn, records, events, fields)
    ops = weboptions('CertificateFilename', '', 'Debug', false);
    records = char(join(string(records),','));
    fields = char(join(fields,','));
    events = char(join(events,','));
    result = webwrite(conn.url, 'token', conn.token, ...
        'content','record', ...
        'format','csv', ...  % csv format 
        'type','flat', ...
        'records', records, ...
        'fields', fields, ...
        'events', events, ...
        'rawOrLabel','raw', ...
        'rawOrLabelHeaders','raw', ...
        'exportCheckboxLabel','false', ...
        'exportSurveyFields','false', ...
        'exportDataAccessGroups','false', ...
        'returnFormat','json', ops);
    % csv format has the effect that result is a table with date in the
    % DD-Mon-YYYY format. The `table_format` assumes csv format.
    % json format would return an array of records, with dates in
    % YYYY-MM-DD format. 
    result = table_format(result, conn.table_format);
end