% redcap_longitudinal_example.m 
%
%% Example of longitudinal Project
%
% The following csv file should be manually uploaded in REDCap Project
% Setup:
%
% * 'DataDictionary.csv' :       Data dictionary (same as basic example)
%                                (=> Design instruments / Data Dictionary)
% * 'Events.csv':                list of events  
%                                (=> Define My Events) 
% * 'InstrumentDesignations.cs': mapping between events and instruments
%                                (=> Designate Instruments for My Events)
%
% This longitudinal project includes two events named 'event_1' and 'event_2'. 
% Both events contain 'instrument_1' and 'instrument_2'.
%

%% Initialization

% Define REDCap URL and token for the connection
% This line can be commented out and the information entered directly in
% `redcap_connection`.
run('redcap_api_token.m'); 

% Define a connection handle, i.e. a structure with REDCap connection, 
% project information and some options
db_conn = redcap_connection( ...
  redcap_url, ...                   % insert url of redcap server
  redcap_token, ...                 % insert redcap api token 
  false, ...                        % project is not longitudinal
  'table_format', 'cell2string');   % format options


%% List of events 
redcap_read_events(db_conn)

%% Write records

% Ffield names for the two instruments
field_names_1 = ["text_box" "numeric_box" "dropbox" "radiobutton" ...
                 "likert_1" "likert_2" "likert_3"];
field_names_2 = ["date" "time" "datetime" "file"];

% Array containing information for two records
data = [ ...
    struct('record', 1, ...            % integer
           'event', 'event_1', ...     % (only for longitudinal projects)
           'field', field_names_1, ... % array of strings
           'value', ["First record" "10"   "1" "1"  "2" "2" "1"] ...
       ), ...
    struct('record', 2, ...                  % integer
           'event', 'event_2', ...   % (only for longitudinal projects)
           'field', ["text_box"  "date" "time"], ... % array of strings
           'value', ["Second record" "2024-12-31" "20:30"] ...
       ), ...
    ];
% Write both records in REDCap 
redcap_write(db_conn, data)

%%
% Create a third record and initialize it     
redcap_write_record(db_conn, 1, 'event_2', ["text_box" "date" "time" "datetime"], ...
    ["Third record" "2024-01-01" "09:30" "2024-01-02 09:30"]) 


%% Read records
%
% * For longitudinal project, the `redcap_read returns a table with a row for 
%   each event. It best to specify the event(s) and the fields that correspond 
%   to these events. 
% * If two or more events are specified, the function returns a row for each 
%   combination of events and records stored in the database
% * If no events  (events = '') and no records (records=[]) are specified,
%   it will return a table with a row for each combination of events and 
%   records stored in the database.

% Read fields for all events of two records
redcap_read(db_conn, [1 2], '', ["text_box" "date" "time"])
%%
% return the whole record for one record  
% note that there is one line per event and a column for each
% field in the databse
redcap_read(db_conn, 1 , '', '' )
%%
% Select event
% note that there is still a column for every field in the databse
redcap_read(db_conn, 1, 'event_2', '' )
%%
% Table with all records and all fields
redcap_read(db_conn, [], '', '' )
