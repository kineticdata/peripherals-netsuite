# NetSuite Custom Record Update
Using Update of Custom Fields on a Custom Form the [NetSuite SDK](https://github.com/NetSweet/netsuite).

## Parameters
[Error Handling]
    Select between returning an error message, or raising an exception.

[Type Id]
  The Custom Record Type Id

[Internal Id]
    The Id of the record that is being updated.

[Attributes]
    JSON array of custom feild objects to update.

### Sample Parameters
    "error_handling" => "Rasie Error",
    "type_id" => "555",
    "internal_id" => "55555",
    "attributes" => '[{
      "value" : "Test Value",
      "internal_id" : "1596",
      "type" :  "platformCore:StringCustomFieldRef",
      "script_id" : "custrecord_ts_field"
    },{
      "value" : "147.0",
      "type" : "platformCore:DoubleCustomFieldRef",
      "internal_id" : "1480",
      "script_id" : "custrecord_ts_another_field"
    }]'

## Results
[Handler Error Message]
  Error message if an error was encountered and Error Handling is set to "Error Message".
[Output]
    The returned value from the Rest Call (JSON format)

## Important Notes
* Version 2021_1 of the SOAP api is used by the handler.
* TBA authentication is required for the handler.  For information on setting up TBA in the Netsuite environment visit [Getting Started with Token-based Authentication](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_4247337262.html)
