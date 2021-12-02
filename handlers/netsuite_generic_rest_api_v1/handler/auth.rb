## REFERENCE INFO ##
# https://www.ledgersync.dev/posts/netsuite-authentication/
# https://github.com/LedgerSync/ledger_sync-netsuite/blob/97d240f33a0908e428bded54d83f0f5cc6860478/lib/ledger_sync/netsuite/token.rb

# Escape Method for Auth
def escape_cgi(str)
  CGI.escape(str.to_s).gsub(/\+/, "%20")
end

# Generate Signature for authentication
def build_signature(method, url, consumer_key, consumer_secret, token_id, token_secret, nonce, timestamp)
  uri = URI(url)
  url_without_params = "#{uri.scheme}://#{uri.host}#{uri.path}"
  url_params = uri.query.nil? ? {} : CGI.parse(uri.query).transform_values(&:first)

  oauth_parameters_array = {
    oauth_consumer_key: consumer_key,
    oauth_nonce: nonce,
    oauth_signature_method: @signature_method,
    oauth_timestamp: timestamp,
    oauth_token: token_id,
    oauth_version: @oauth_version,
  }.to_a

  parameters_string = url_params.to_a
    .concat(oauth_parameters_array)
    .map { |k, v| [escape_cgi(k), escape_cgi(v)] }
    .sort { |a, b| a <=> b }
    .map { |e| "#{e[0]}=#{e[1]}" }
    .join("&")

  signature_data_string = [
    method,
    escape_cgi(url_without_params),
    escape_cgi(parameters_string),
  ].join("&")

  key = [
    consumer_secret,
    token_secret,
  ].join("&")

  signature = escape_cgi(Base64.encode64(
    OpenSSL::HMAC.digest(
      OpenSSL::Digest.new("sha256"),
      key,
      signature_data_string
    )
  ).strip)

  return signature
end

def build_headers(method, url, consumer_key, consumer_secret, token_id, token_secret, nonce, timestamp)
  # Setup Header Parts
  authorization_parts = [
    [:realm, @realm],
    [:oauth_consumer_key, escape_cgi(@consumer_key)],
    [:oauth_token, escape_cgi(@token_id)],
    [:oauth_signature_method, escape_cgi(@signature_method)],
    [:oauth_timestamp, @timestamp],
    [:oauth_nonce, @nonce],
    [:oauth_version, @oauth_version],
    [:oauth_signature, build_signature(method, url, consumer_key, consumer_secret, token_id, token_secret, nonce, timestamp)],
  ]

  # Build & return headers object
  return {
           "Authorization" => "OAuth #{authorization_parts.map { |k, v| "#{k}=\"#{v}\"" }.join(",")}",
         }
end
