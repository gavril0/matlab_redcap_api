% redcap_write_record - Write a single record  in REDCap database
%
% Syntax
% ------
% result = redcap_write_record(conn, record_id, event, fields, values) 
%
% Description
% -----------
% `redcap_write_record` writes a single record  in REDCap database:
% - `conn`: REDCap connection handle (see `redcap_connection`)
% - record_id: record ID (integer)
% - event: event name (string, '' for non-longitudinal project)
% - fields: array of field names (array of strings)
% - values: array of values. All values must be strings, including numbers.
%           Dates must be in YYYY-MM-DD format. 
%
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function result = redcap_write_record(conn, record_id, event, fields, values) 
  % simple wrapper to write a single record
  data = [ ...
      struct('record', record_id, ... % integer
             'event', event, ...      % (only for longitudinal projects)
             'field', fields, ...     % array of strings
             'value', values ...      % array of strings
         ) ...
    ];
  result = redcap_write(conn, data);
end