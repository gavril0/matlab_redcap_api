function result = REDCap_read(conn, records, events, fields)
% REDCap_read - Read records
%
% Parameters:
%   conn: REDCap connection structure
%   records: record IDs (array of integers; [] for all records)
%   events: event name  (array of strings, [] for all events)
%   fields: field names (array of strings, "" for all fields)
%
% Value: 
%   result: Table with records. 
%
% Details:
%   The format depends on whether the project is longitudinal or not: 
%   - For non-longitudinal projects, the table has one row for each record and one column for each field
%   - For longitudinal projects, the table has one a row for each event/record combination and a column for each fied.
%     - If two or more events are specified, it will return a row for each combination of events and 
%       records stored in the database
%     - If no events  (events = '') and no records (records=[]) are specified,
%       it will return a table with one row for all combinations of events and 
%       records stored in the database
%     - To avoid results with a lot of "missing" value, it good practice to specify the event(s) 
%       with the fields that corresponds to these events. 
%     - For longitudinal projects, it is not possible to get one row by record with all fields from all events. 
    ops = weboptions('CertificateFilename', '', 'Debug', false);
    records = char(join(string(records),','));
    fields = char(join(fields,','));
    events = char(join(events,','));
    result = webwrite(conn.url, 'token', conn.token, ...
        'content','record', ...
        'format','csv', ...
        'type','flat', ...
        'records', records, ...
        'fields', fields, ...
        'events', events, ...
        'rawOrLabel','raw', ...
        'rawOrLabelHeaders','raw', ...
        'exportCheckboxLabel','false', ...
        'exportSurveyFields','false', ...
        'exportDataAccessGroups','false', ...
        'returnFormat','csv', ops);
    result = table_format(result, conn.table_format);
end