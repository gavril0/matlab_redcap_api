% redcap_basic_example.m
%
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
%% Basic project requirements
%  
% * Create a REDCap project:  Define the instruments by uploading the data dictionary
%   in the project folder (data_dictionary.csv)
% * Insert the URL of the REDCap server and REDCap API token in the script:
%    see API section in the REDCap project left column
% * You must have necessary privilege to execute the desired commands.
%   You might get error 403 if you lack privilege (Error 403 indicates that the 
%   server understands the request but refuses to authorize it).
%    
% The project contains two instruments named "instrument 1" and "instrument 2"
% with an instance of the main field types (text, number, date, etc.). 

%% Defining connection handle

% Initialize urk and token. This script not included in the repository. 
% Insert the url of your REDCap server and token directly in the next command. 
run('redcap_api_token.m');           

% Connection handle 
db_conn = redcap_connection( ...
  redcap_url, ...                   % insert url of redcap server
  redcap_token, ...                 % insert redcap api token 
  false, ...                        % project is not longitudinal
  'table_format', 'cell2string');    % format options

%% Download data dictionary 
redcap_read_dictionary(db_conn, ["instrument 1" "instrument 2"])

%% Write records
%
% * The data argument is an array of structures specifying values for different 
%   records. Fields values are specified via a vector of strings (including for number). 
%   The length of the value array must corresponds to the length of the field
%   name array.  It is possible to specify different fields for different records.
% * The record will be automatically created if the record_id does not exist.
% * Existing data are overwritten. 
% * The instrument name is not needed because field names are unique

field_names = ["text_box" "numeric_box" "dropbox" "radiobutton" "likert_1" "likert_2" "likert_3"];
data = [ ...
    struct('record', 1, ...            
           'field', field_names, ... 
           'value', ["First record" "10"   "1" "2"   "2" "2" "1"] ...     
       ), ...
    struct('record', 2, ...                   
           'field',  ["text_box" "date" "time" "datetime"], ...
           'value', ["Second record" "2024-01-02" "09:30" "2024-01-02 09:30"] ... 
       ) ...
    ];

% Write multiple records
redcap_write(db_conn, data)

%%
% The `redcap_write_record` function is a wrapper around the 
% `redcap_write` function that can be used to write value of a single
% record.

redcap_write_record(db_conn, 2, '',  field_names, ["Second record" "20"   "2" "1"   "1" "2" "1"]) 
%% 
redcap_write_record(db_conn, 1, '', ["date" "time" "datetime"], ["2024-02-01" "09:30" "2024-02-01 09:30"]) 
%%
% Update instrument status
redcap_write_record(db_conn, 1, '', ["instrument_1_complete"], ["2"]) 

%% Read records

% Read all records
redcap_read(db_conn, [], '', '')
%%
% Read a subset of records and fields
redcap_read(db_conn, [1], '', field_names)

%% Upload and Download a file

% Upload a text file 
redcap_write_file(conn, 1, '', 'file', 'LICENSE.txt')
%% 
% Download a text file
redcap_read_file(conn, 1, '', 'file')
%% 
% Upload an jpeg image
redcap_write_file(conn, 1, '', 'file', 'html/test_image.jpg')
%%
% Download jpeg image
img = redcap_read_file(conn, 1, '', 'file');
imshow(img);

%% Delete records

% catch possible error if privilege are insufficient 
try
    result = redcap_delete(db_conn, [2]);
catch exc
    disp(exc);
end
