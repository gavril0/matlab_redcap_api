%% Commands to communicate with REDCap RESTFul web services 
% Version 1.2 10-02-2024
%
%% Description of first group of files
%   redcap_read             - read record(s)  
%   redcap_write            - write record(s)
%   redcap_write_record     - write value(s) for a single record
%   redcap_read_file        - download data dictionary
%   redcap_read_dictionary  - download data dictionary
%   redcap_read_events      - download list of events (only longitudinal project)
%   redcap_read_report      - download a report (pdf)
% 
%% Utility functions
%   redcap_connection       - create a handle to connect to REDCap web services
%   table_format            - format table returned by commands (also used by some
%                             commands internally, see format argument)
%% Miscelleanous
%   redcap_basic_example    - examples of use of the commands
%   html/                   - folder with the examples output (redcap_examples.html)
%   project/                - folder with CSV files to configure the REDCAP projects
%                             used in the examples
% See also readme.md
% 
% For more information on REDCap, see the <a href="redcap: 
% web('https://www.project-redcap.org/')">REDCap Organization</a>.
%
% Public repository: https://github.com/gavril0/redcap_matlab_api
% Copyright 2024 Gabriel Baud-Bovy (gbaudbovy@gmail.com)
