# Netsuite Generic Rest API
This integration was built to work with the Netsuite Record SOAP api. It is generic in nature and can be use with with [Netsuite SOAP Browser](https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2021_2/schema/record/account.html). 

## Parameters
[Error Handling]
    Select between returning an error message, or raising an exception.

[Output Type]
  The output type to return from a successful call.  Options are JSON or XML.

[Operation]
    An operation supported for resource being requested.  This must match the xml operation.  For more information visit [SOAP Web Services Operations](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/chapter_N3477815.html).

[XML]
The XML body that will be added to the envelope prior. To learn more and find examples of xml body requirements visit [SuiteTalk SOAP Web Services Records Guide](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/book_156388697975.html)

### Sample XML values
#### Get Opportunity
``` xml
<get xsi:type='platformMsgs:GetRequest'>
    <baseRef xsi:type='platformCore:RecordRef' internalId='367340' type='opportunity'/>
</get>
```
#### Get Custom Entry
``` xml
<get xmlns='urn:customization.setup.webservices.netsuite.com'>
    <baseRef internalId='10347' typeId='219' xsi:type='ns6:CustomRecordRef' xmlns:ns6='urn:core_2021_1.platform.webservices.netsuite.com'/>
</get>
```

## Results
[Handler Error Message]
  Error message if an error was encountered and Error Handling is set to "Error Message".
[Output]
    The returned value from the Rest Call (JSON format)

## Important Notes
* Version 2021_1 of the SOAP api is used by the handler.
* The handler assumes `urn:core_2021_1.platform.webservices.netsuite.com` namespace.
* The handler builds the headers node and appends the provided body.  Below is the hardcoded envelope.
    ``` xml
    <soapenv:Envelope 
        xmlns:xsd='http://www.w3.org/2001/XMLSchema'
        xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'
        xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'
        xmlns:platformCore='urn:core_2021_1.platform.webservices.netsuite.com'
        xmlns:platformMsgs='urn:messages_2021_1.platform.webservices.netsuite.com'>
        <soapenv:Header>#{headers}</soapenv:Header>
        <soapenv:Body>#{@xml}</soapenv:Body>
    </soapenv:Envelope>
    ```
* Make note the prefix used is xsi.
* TBA authentication is required for the handler.  For information on setting up TBA in the Netsuite environment visit [Getting Started with Token-based Authentication](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_4247337262.html)
