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
    "error_handling" => "Error Message",
    "method" => "GET",
    "path" => "/opportunity/25974", # The Base URL is https://#{@netsuite_environment}.suitetalk.api.netsuite.com/services/rest/record/v1
    "body" => "",
    "query" => "",
  },
}
