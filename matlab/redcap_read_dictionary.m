% redcap_read_ dictionary - Download data dictionary
%
% Syntax
% ------
% results = readcap_read_dictionary(conn, forms)
%
% Description
% -----------
% `redcap_read_ dictionary`  retuns the data dictionary, i.e. a table describing the variables 
%  in form sof the project:  
%  - `conn` is REDCap connection handle (see `redcap_connection`).
%  - `forms` specify the form names (array of strings, [] for all forms).
%
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function result = redcap_read_dictionary(conn, forms)
    ops = weboptions('CertificateFilename', '', 'Debug', false);
    n_forms = length(forms);
    args = cell(1, 8+2*n_forms);
    args(1:8) = { ...
           'token', conn.token, ... 
          'content', 'metadata', ...
          'format','csv', ...
          'returnFormat','csv'};
    if(n_forms>0)
        args(9:2:(9 + 2*(n_forms-1))) = cellstr(strcat('forms[', string(0:(n_forms-1)), ']='));
        args(10:2:(10 + 2*(n_forms-1))) = cellstr(forms);
    end
    fstr = ['webwrite(conn.url,''' char(join(args,''',''')) ''',ops)'];
    result = eval(fstr);
    result = table_format(result, conn.table_format);
end

