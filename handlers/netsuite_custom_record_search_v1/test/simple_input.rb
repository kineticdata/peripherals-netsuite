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
    "internal_id" => "219",
    "search" => '[
      {
        "field" : "created",
        "operator" : "within",
        "type" : "SearchDateField",
        "value" : [
          "2022-02-03T22:00:00.000-07:00",
          "2022-02-04T22:00:00.000-07:00"
        ]
      }
    ]',
    "columns" => '{    
      "setupCustom:basic" : {
        "platformCommon:internalId" : {},
        "platformCommon:lastModified" : {},
        "platformCommon:recType": {}
      }
    }',
    "preferences" => '{}'
  },
}