```
Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
```
# Matlab API for REDCap

## Version 1.0

* New functions:
  * `redcap_write_file` and `redcap_read_file`: Upload and download a file
  * `redcap_delete`: Delete record(s) 
  * `redcap_read_dictonary`: Download data dictionary
  * `redcap_write_record`: Write a singe record
* Added two examples: 
    * `redcap_basic_example.m` and `redcap_longitudinal_example.m`
    * the `redcap_project/` folder contains the configuration file for the REDCAP project
      for the examples
    * the `html/` folder contains the output of the examples (publish). 
* Renamed some functions:
  * `redcap_read_events` (previously `REDCap_events)
  * `redcap_read_report` (previously `REDCap_report)    
* Changed names of all function to lower cases for consistency   
* Improved documentation

## Version 0.9

Telecyclette Version [commit: d90f8a2, tag v0.9]. 

This initial commit contains functions in use in Telecyclette software (Jan-Oct. 2024).
 
 
 
