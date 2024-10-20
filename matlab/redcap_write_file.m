% redcap_write_file - upload a file 
%
% Syntax
% ------
% function result = redcap_write_file(conn, record, event, field, filename)
%
% Description
% -----------
% `redcap_write_file` uploads a file. The arguments are 
% - `conn`: REDCap connection structure (see `redcap_connection`)
% - `record`: record ID (integer)
% - `event`: event name ('' if the project is not longitudinal)
% - `field`: name of the field that 
% - `filename`: name of the file to upload
% Return a logical (1 if completed successifuly, 0 otherwise).
% 
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function result = redcap_write_file(conn, record, event, field, filename)

% read file content 
% filename = "LICENSE.txt"

% FileProvider converts data from an internal form into a uint8 stream
fileProvider = matlab.net.http.io.FileProvider(filename);
% Multi-Part Provider
mpProvider  = matlab.net.http.io.MultipartFormProvider( ...
        'token', conn.token, ...
        'content','file', ...
        'action', 'import', ...
        'record', char(string(record)),... 
        'event', event, ...
        'field', field, ...
        'file', fileProvider);
% POST request
req = matlab.net.http.RequestMessage('post',[],mpProvider);
% send request
options = matlab.net.http.HTTPOptions('ConvertResponse', false);
response = req.send(conn.url, options);
result = response.Completed;
end

