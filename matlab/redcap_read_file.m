% redcap_read_file - Download a file 
%
% Syntax
% ------
% result = redcap_read_file(conn, record, event, field) 
%
% Description
% -----------
%  `redcap_write_file` downloads a file. 
%  - `conn`: REDCap connection structure
%  - `record`: record ID (integer) 
%  - `event`: unique event name (e.g. 'event_1_arm_1' for longitudinal project, 
%             '' otherwise; see list of events)
%  - `field`: name of the field containing the file.
% The type of `result` depends on the file (.e.g `char` for text, `uint8` for jpg) 
% The function throws a "Bad Request" error if the files or event does not exist.
%
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function result = redcap_read_file(conn, record, event, field)
ops = weboptions('CertificateFilename', '', 'Debug', false);
result = webwrite(conn.url, 'token', conn.token, ...
        'content','file', ...
        'action', 'export', ...
        'record', char(string(record)),... 
        'event', event,...
        'field', field, ...
        'returnFormat','json', ops);
end

