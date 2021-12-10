# Require the dependencies file to load the vendor libraries
require File.expand_path(File.join(File.dirname(__FILE__), "dependencies"))
require File.expand_path(File.join(File.dirname(__FILE__), "auth"))

class NetsuiteGenericSoapApiV1
  # ==== Parameters
  # * +input+ - The String of Xml that was built by evaluating the node.xml handler template.
  def initialize(input)
    # Set the input document attribute
    @input_document = REXML::Document.new(input)

    # Retrieve all of the handler info values and store them in a hash variable named @info_values.
    @info_values = {}
    REXML::XPath.each(@input_document, "/handler/infos/info") do |item|
      @info_values[item.attributes["name"]] = item.text.to_s.strip
    end

    # Retrieve all of the handler parameters and store them in a hash variable named @parameters.
    @parameters = {}
    REXML::XPath.each(@input_document, "/handler/parameters/parameter") do |item|
      @parameters[item.attributes["name"]] = item.text.to_s.strip
    end

    @debug_logging_enabled = ["yes", "true"].include?(@info_values["enable_debug_logging"].downcase)
    @error_handling = @parameters["error_handling"]

    @netsuite_environment = @info_values["netsuite_environment"]
    @consumer_key = @info_values["consumer_key"]
    @consumer_secret = @info_values["consumer_secret"]
    @token_id = @info_values["token_id"]
    @token_secret = @info_values["token_secret"]
    @nonce = Array.new(20) { [*"0".."9", *"A".."Z", *"a".."z"].sample }.join
    @timestamp = Time.now.to_i
    @oauth_version = "1.0"
    @signature_method = "HMAC-SHA256"

    @api_location = "https://#{@netsuite_environment}.suitetalk.api.netsuite.com/services/NetSuitePort_2021_1"
    @xml = @parameters['xml']
    @method = (@parameters["method"] || "get").upcase
  end

  def execute
    # Initialize return data
    error_message = nil
    error_key = nil
    response_code = nil

    begin
      puts "XML Body: #{@xml}" if @debug_logging_enabled
      puts "API Location: #{@api_location}" if @debug_logging_enabled

      # Setup savon client
      client = Savon.client(endpoint: @api_location, namespace: 'urn:core_2021_1.platform.webservices.netsuite.com')

      # build xml headers
      headers = build_header(@netsuite_environment, @consumer_key, @consumer_secret, @token_id, @token_secret, @nonce, @timestamp)

      # build envelope
      envelope = REXML::Document.new(
        "<soapenv:Envelope 
          xmlns:xsd='http://www.w3.org/2001/XMLSchema'
          xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'
          xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'
          xmlns:platformCore='urn:core_2021_1.platform.webservices.netsuite.com'
          xmlns:platformMsgs='urn:messages_2021_1.platform.webservices.netsuite.com'>
          <soapenv:Header>#{headers}</soapenv:Header>
          <soapenv:Body>#{@xml}</soapenv:Body>
        </soapenv:Envelope>"
      )

      # make call
      response = client.call(@parameters["operation"].to_sym, xml: envelope.to_s)

      # transform output
      result = @parameters["output_type"].upcase == "JSON" ? 
        response.body.to_json : response.to_xml

    rescue Exception => error
      error_message = error.inspect
      raise error if @error_handling == "Rasie Error"
    end

    # Return (and escape) the results that were defined in the node.xml
    <<-RESULTS
    <results>
      <result name="Output">#{escape(result.nil? ? {} : result)}</result>
      <result name="Handler Error Message">#{escape(error_message)}</result>
    </results>
    RESULTS
  end

  ##############################################################################
  # General handler utility functions
  ##############################################################################

  # This is a template method that is used to escape results values (returned in
  # execute) that would cause the XML to be invalid.  This method is not
  # necessary if values do not contain character that have special meaning in
  # XML (&, ", <, and >), however it is a good practice to use it for all return
  # variable results in case the value could include one of those characters in
  # the future.  This method can be copied and reused between handlers.
  def escape(string)
    # Globally replace characters based on the ESCAPE_CHARACTERS constant
    string.to_s.gsub(/[&"><]/) { |special| ESCAPE_CHARACTERS[special] } if string
  end

  # This is a ruby constant that is used by the escape method
  ESCAPE_CHARACTERS = { "&" => "&amp;", ">" => "&gt;", "<" => "&lt;", '"' => "&quot;" }
end
