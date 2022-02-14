# NetSuite Generic Rest API
This integration was built to work with the NetSuite Record REST api. It is generic in nature and can be used
to integrate with all Record REST resources which are documented here: https://system.netsuite.com/help/helpcenter/en_US/APIs/REST_API_Browser/record/v1/2021.2/index.html

## Parameters
[Error Handling]
    Select between returning an error message, or raising an exception.

[Method]
    HTTP Method to use for the NetSuite REST API call being made. Options are: - GET - POST - PUT - PATCH - DELETE

[Path]
    The relative API path (from `https://NETSUITE_ENVIRONMENT.suitetalk.api.netsuite.com/services/rest/record/v1`)that will be called. This value should begin with a forward slash `/`.

[Body]
    The body content (JSON) that will be sent for POST, PUT, and PATCH requests.

## Results
[Response Body]
    The returned value from the Rest Call (JSON format)
