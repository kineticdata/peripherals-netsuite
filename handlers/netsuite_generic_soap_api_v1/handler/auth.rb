# Generate Signature for authentication
def build_signature(netsuite_environment, consumer_key, consumer_secret, token_id, token_secret, nonce, timestamp)

  # Build basestring by concat of parameters
  signature_data_string = [
    netsuite_environment, 
    consumer_key, 
    token_id, 
    nonce, 
    timestamp
  ].join("&")

  # Build key by concat of secrets
  key = [
    consumer_secret,
    token_secret,
  ].join("&")

  # Build signature sha256 matches envelope value
  signature = Base64.encode64(
    OpenSSL::HMAC.digest(
      OpenSSL::Digest.new("sha256"),
      key,
      signature_data_string
    )
  ).strip

  puts "Returning Signature" if @debug_logging_enabled 
  return signature
end

def build_header(netsuite_environment, consumer_key, consumer_secret, token_id, token_secret, nonce, timestamp, signature_method)

  # Transform the account id
  netsuite_environment_transform = netsuite_environment.gsub(/-/, "_").upcase

  puts "Convert Account Id from '#{netsuite_environment}' to '#{netsuite_environment_transform}'" if @debug_logging_enabled

  # Build & return headers node
  return { 'tokenPassport' =>
    {
      'account' => netsuite_environment_transform,
      'consumerKey' => consumer_key,
      'token' => token_id,
      'nonce' => nonce,
      'timestamp' => timestamp,
      'signature' =>  build_signature(netsuite_environment_transform, consumer_key, consumer_secret, token_id, token_secret, nonce, timestamp),
      :attributes! => {
        'signature' => {
          'algorithm' => signature_method
        }
      }
    }
  }
end
