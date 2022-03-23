# Netsuite Generic Rest API
This integration was built to work with the Netsuite Record SOAP api. It is generic in nature and can be use with with [Netsuite SOAP Browser](https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2021_2/schema/record/account.html). 

## Parameters
[Error Handling]
    Select between returning an error message, or raising an exception.

[Output Type]
  The output type to return from a successful call.  Options are JSON or XML.

[Operation]
    An operation supported for resource being requested.  This must match the xml operation.  For more information visit [SOAP Web Services Operations](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/chapter_N3477815.html).

[Body]
The body that will be converted to xml and added to the envelope prior. To learn more and find examples of xml body requirements visit [SuiteTalk SOAP Web Services Records Guide](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/book_156388697975.html).  The examples will need to be converted to JSON.

### Sample JSON values
#### Get Opportunity
``` json
{
  "platformMsgs:baseRef": {
    "@xsi:type": "platformCore:RecordRef",
    "@type": "opportunity",
    "@internalId": 557340
  }
}
```
#### Get Custom Entry
``` json
{
  "platformMsgs:baseRef": {
    "@xsi:type": "platformCore:CustomRecordRef",
    "@typeId": 219,
    "@internalId": 2418
  }
}
```
#### Saved Search 
``` json
{
  "platformMsgs:searchRecord": {
    "@savedSearchId": 1893,
    "@xsi:type": "setupCustom:CustomRecordSearchAdvanced",
    "setupCustom:criteria": {
      "setupCustom:basic" : {
        "platformCommon:created": {
          "@operator": "within",
          "platformCore:searchValue": "2022-01-01T22:00:00.000-07:00",
          "platformCore:searchValue2": "2022-01-31T22:00:00.000-07:00"
        },
        "platformCommon:recType": {
          "@internalId": 219
        }
      }
    }
  }
}
```

#### Search Opportunities
``` json
{
  "platformMsgs:searchRecord": {
    "@xsi:type": "tranSales:OpportunitySearch",
    "tranSales:basic": {
      "platformCommon:lastModifiedDate": {
        "@operator": "within",
        "platformCore:searchValue": "2022-03-21T06:00:01.000-00:00",
        "platformCore:searchValue2": "2022-03-22T06:00:01.000-00:00"
      }
    }
  }
}
```

## Results
[Handler Error Message]
  Error message if an error was encountered and Error Handling is set to "Error Message".
[Output]
    The returned value from the Rest Call (JSON format)

## Important Notes
* Version 2021_1 of the SOAP api is used by the handler.
* The handler looks for a wsdl at https://webservices.netsuite.com/wsdl/v2021_2_0/netsuite.wsdl.
* When building the body json it is important to note that `@` is used to add an attribute to the parent when converted to xml.  
* TBA authentication is required for the handler.  For information on setting up TBA in the Netsuite environment visit [Getting Started with Token-based Authentication](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_4247337262.html)
