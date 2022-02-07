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
    "saved_id" => "1803",
    "search" => '[
      {
        "field" : "created",
        "operator" : "within",
        "type" : "SearchDateField",
        "value" : [
          "2022-01-01T22:00:00.000-07:00",
          "2022-01-31T22:00:00.000-07:00"
        ]
      }
    ]',
    "preferences" => '{}'
  },
}