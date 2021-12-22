{
  "info" => {
    "netsuite_environment" => "", #ie: 123456-sb1
    "consumer_key" => "",
    "consumer_secret" => "",
    "token_id" => "",
    "token_secret" => "",
    "enable_debug_logging" => "yes",
  },
  "parameters" => {
    "error_handling" => "Raise Error",
    "internal_id" => "555",
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
  },
}