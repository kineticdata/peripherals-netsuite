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

def build_header(netsuite_environment, consumer_key, consumer_secret, token_id, token_secret, nonce, timestamp)

  # Transform the account id
  netsuite_environment = netsuite_environment.gsub(/-/, "_").upcase

  puts "Convert Account Id from '#{netsuite_environment}' to #{netsuite_environment}" if @debug_logging_enabled

  # Build & return headers node
  return {
    'platformMsgs:tokenPassport' => {
      'platformCore:account' => netsuite_environment,
      'platformCore:consumerKey' => consumer_key,
      'platformCore:token' => token_id,
      'platformCore:nonce' => nonce,
      'platformCore:timestamp' => timestamp,
      'platformCore:signature' => build_signature(netsuite_environment, consumer_key, consumer_secret, token_id, token_secret, nonce, timestamp),
      :attributes! => { 'platformCore:signature' => { 'algorithm' => 'HMAC-SHA256' } }
    }
  }
end
