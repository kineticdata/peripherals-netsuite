{
  "info" => {
    "netsuite_environment" => "", #ie: 123456-sb1
    "consumer_key" => "",
    "consumer_secret" => "",
    "token_id" => "",
    "token_secret" => "",
    "enable_debug_logging" => "no",
  },
  "parameters" => {
    "error_handling" => "Rasie Error",
    "output_type" => "JSON",
    "operation" => "get",
    "message" => '{
      "baseRef": "",
      "attributes!": {
        "baseRef": {
          "xsi:type": "platformCore:RecordRef", 
          "internalId": "367340",
          "type": "opportunity"
        }
      } 
    }',
    "attributes" => '{
      "xsi:type": "platformMsgs:GetRequest",
      "xmlns:platformCore": "urn:core_2021_1.platform.webservices.netsuite.com"
    }'
  },
}
