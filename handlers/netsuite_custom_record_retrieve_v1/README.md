# NetSuite Custom Record Retrieve
Retrieve a single Custom Record using the [NetSuite SDK](https://github.com/NetSweet/netsuite).

## Parameters
[Error Handling]
  Select between returning an error message, or raising an exception.

[Internal Id]
  The Custom Record Type Id.

[Type Id]
  The Id of the Form Type that the record matches.

### Sample Parameters
``` ruby
  "error_handling" => "Raise Error",
  "internal_id" => "55555",
  "type_id" => '555'
``` 

## Results
[Handler Error Message]
  Error message if an error was encountered and Error Handling is set to "Error Message".
  
[Output]
    The returned value from the SDK request (A record in JSON format)

## Important Notes
* Version 2021_1 of the SOAP api is used by the handler.
* TBA authentication is required for the handler.  For information on setting up TBA in the Netsuite environment visit [Getting Started with Token-based Authentication](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_4247337262.html).
