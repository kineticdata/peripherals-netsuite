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
  return "<tokenPassport xsi:type='platformCore:TokenPassport'>
      <account xsi:type='xsd:string'>#{netsuite_environment}</account>
      <consumerKey xsi:type='xsd:string'>#{consumer_key}</consumerKey>
      <token xsi:type='xsd:string'>#{token_id}</token>
      <nonce xsi:type='xsd:string'>#{nonce}</nonce>
      <timestamp xsi:type='xsd:long'>#{timestamp}</timestamp>
      <signature algorithm='HMAC_SHA256' xsi:type='platformCore:TokenPassportSignature'>#{build_signature(netsuite_environment, consumer_key, consumer_secret, token_id, token_secret, nonce, timestamp)}</signature>
  </tokenPassport>"
end
