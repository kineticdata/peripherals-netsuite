# NetSuite Custom Record Update
Perform search for Custom Records using the [NetSuite SDK](https://github.com/NetSweet/netsuite).

## Parameters
[Error Handling]
  Select between returning an error message, or raising an exception.

[Internal Id]
  The Custom Record Type Id.

[Search]
  Additional basic search parameters.  This value must be a JSON array.  

[Preferences]
  Preferences passed to the search. e.g. pageSize

### Sample Parameters
``` ruby
  "error_handling" => "Raise Error",
  "internal_id" => "55555",
  "search" => '[
    {
      "field" : "created",
      "operator" : "within",
      "type" : "SearchDateField",

      "value" : [
        "2021-01-01T22:00:00.000-07:00",
        "2021-12-20T22:00:00.000-07:00"
      ]
    }
  ]',
  "preferences" => '{
    "page_size" : 5,
    "body_fields_only" : true
  }'
``` 

## Results
[Handler Error Message]
  Error message if an error was encountered and Error Handling is set to "Error Message".
  
[Output]
    The returned value from the SDK request (Array of records in JSON format)

## Important Notes
* Version 2021_1 of the SOAP api is used by the handler.
* TBA authentication is required for the handler.  For information on setting up TBA in the Netsuite environment visit [Getting Started with Token-based Authentication](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_4247337262.html).
* The handler does not currently support all possible search features.
* IMPORTANT: The below basic search parameter is automatically added to the request:
``` ruby
{
  :field => 'recType',
  :operator => 'is',
  :value => NetSuite::Records::CustomRecordRef.new(:internal_id => <internal id parameter value>),
}
```