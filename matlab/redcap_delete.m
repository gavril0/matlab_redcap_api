% redcap_delete - Delete records
%
% Syntax
% ------
% results = redcap_delete(conn, records)
%
% Description
% -----------
% `redcap_delete` deletes the record(s) specified in `records` array
%  of record IDs (integers). Use `[]` to deleted all records.
%  `conn` must be a connection handle.
%  
% Example
% -------
% db_conn = redcap_connect(url, token, longitudinal);
% redcap_delete(db_conn, [1 2]) 
%
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function result = redcap_delete(conn, records)
  ops = weboptions('CertificateFilename', '', 'Debug', false);
  records = char(join(string(records),','));
  result = webwrite(conn.url, 'token', conn.token, ...
        'content','record', ...
        'action','delete',...
        'records', records, ...
        'returnFormat','csv', ops);
end
