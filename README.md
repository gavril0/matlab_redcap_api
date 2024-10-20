```
Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
```

# Background information

[**REDCap**](https://projectredcap.org/) is an organization that provides
web-based software to manage research projects. The REDCap server includes
a RESTful web service (aka *REDCap API*) for developing software clients
capable of storing and retreiving data from the project database. The REDCap
API provides a large set of methods to manage the project in addition of
storing and retrieving data.

This repository contains matlab functions to manage a REDCap project via 
REDCap API. 

The repository includes:

- `matlab/`: folder with matlab functions (must be included in Matlab path)
- `project/`: forlder with data dictionaries of REDCap projects used in the examples
- `html/`: documentation generated from the examples with matlab publish
- `redcap_basic_example.m` and `redcap_longitudinal_example.m`: two scripts 
   illustrating how to use the Matlab API.

The functions require a **REDCap API token** for *authentication*, which can be
found in the REDCAP project (ask REDCap administrator in your institution if
you don't see it).  REDCap tokens are project specific. Access rights provided
by a token are the  same as the access rights of the REDCAP user. 

The functions have been tested on Windows 10 and Windows 11 with Matlab 2023b.
They should be compatible with any matlab version supporting MATLAB RESTful 
[web services](https://www.mathworks.com/help/matlab/http-interface.html)
and [functions](https://www.mathworks.com/help/matlab/internet-file-access.html)
to communicate with REDCap web server.

The software is distributed with MIT license and copyrigth notice. The software
was originally developped at [San Raffaele University](www.unisr.it) for the 
[telecyclette project](www.telecyclette.eu) funded by the
[Velux foundation](https://veluxstiftung.ch/).

# Matlab Redcap API

The following tables include all services supported by REDcap API. THhe second
column reports the name of the corresponding matlab function. Currently, the
MATLAB API includes functions only for a subset of REDCAP service.
Feedback and contributions are wellcome.

### Data management 

| REDCAP service              | Matlab function    | Notes                |
| :----                       | :---               | :---                 |
| Export records              | redcap_read        |  |
| Import records              | redcap_write, redcap_write_record |  |
| Delete records              | redcap_delete      | Not tested |
| Rename records              |                    |  |
| Generate next record name   |                    |  |
| Export a file               | redcap_read_file   | Download a file | 
| Import a file               | redcap_write_file  | Upload a file | 
| Delete a file               |                    |  |

### Project management

| REDCAP service              | Matlab function    | Notes                |
| :----                       | :---               | :---                 |
| Create Project              |                    |  |
| Export arms                 |                    |  |
| Import arms                 |                    |  |
| Delete arms                 |                    |  |
| Export events               | redcap_read_events | For longitudinal project |
| Import events               |                    | For longitudinal project |
| Delete events               |                    | For longitudinal project |
| Export metadata             | redcap_read_dictionary  | Download data dictionary |
| Import metadata             |                    | |
| Export list of field names  | |  |   
                                                
### Users & User Privileges

| REDCAP service              | Matlab function    | Notes                |
| :----                       | :---               | :---                 |
| Export users                |                    |  |
| Import users                |                    |  |
| Delete users                |                    |  |
| Export DAGs                 |                    |  |
| Import DAGs                 |                    |  |
| Delete DAGs                 |                    |  |
| Switch DAGs                 |                    |  |
| Export user-DAG assignment  |                    |  |
| Import user-DAG assignment  |                    |  |
| Export user roles           |                    |  |
| Import user roles           |                    |  |
| Delete user roles           |                    |  |
| Export user-role assignement|                    |  |
| Import user-role assignement|                    |  |
                                              
### File repository

| REDCAP service              | Matlab function    | Notes                |
| :----                       | :---               | :---                 |
| Create folder               |                    |
| Export list of files        |                    |
| Export file                 |                    | 
| Import file                 |                    |  
| Delete file                 |                    |  


