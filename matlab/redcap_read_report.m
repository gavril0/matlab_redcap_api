% redcap_report - download a report
%
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function result = redcap_report(conn,  report_id)
  report_id = sprintf('%d', report_id);
  ops = weboptions('CertificateFilename', '', 'Debug', false);
  result = webwrite(conn.url, 'token', conn.token, 
    'content', 'report', ...
    'report_id', report_id, ...
    'format','csv', ...
    'returnFormat','csv', ...
    ops);
  result = table_format(result, conn.table_format);
end