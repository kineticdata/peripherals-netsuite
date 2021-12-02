# Require the dependencies file to load the vendor libraries
require File.expand_path(File.join(File.dirname(__FILE__), "dependencies"))
require File.expand_path(File.join(File.dirname(__FILE__), "auth"))

class NetsuiteGenericRestApiV1
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
    @realm = @netsuite_environment.gsub(/-/, "_").upcase
    @nonce = Array.new(20) { [*"0".."9", *"A".."Z", *"a".."z"].sample }.join
    @timestamp = Time.now.to_i
    @oauth_version = "1.0"
    @signature_method = "HMAC-SHA256"

    @api_location = "https://#{@netsuite_environment}.suitetalk.api.netsuite.com/services/rest/record/v1"
    @body = @parameters["body"].to_s.empty? ? {} : JSON.parse(@parameters["body"])
    @method = (@parameters["method"] || "get").upcase
    @path = @parameters["path"]
    @path = "/#{@path}" if !@path.start_with?("/")
    @accept = :json
    @content_type = :json
  end

  def execute
    # Initialize return data
    error_message = nil
    error_key = nil
    response_code = nil

    begin
      # full api route including host/path/params
      api_route = "#{@api_location}#{@path}"

      # build headers
      headers = build_headers(@method, api_route, @consumer_key, @consumer_secret, @token_id, @token_secret, @nonce, @timestamp)
      puts "API ROUTE: #{@method.to_s.upcase} #{api_route}" if @debug_logging_enabled
      puts "BODY: \n #{@body}" if @debug_logging_enabled

      # make call
      response = RestClient::Request.execute \
        method: @method.downcase.to_sym, url: api_route, payload: @body.to_json, headers: headers
      response_code = response.code
    rescue RestClient::Exception => e
      error = nil
      response_code = e.response.code

      # Attempt to parse the JSON error message.
      begin
        error = JSON.parse(e.response)
        error_message = error["o:errorDetails"]
      rescue Exception
        puts "There was an error parsing the JSON error response" if @debug_logging_enabled
        error_message = e.inspect
      end

      # Raise the error if instructed to, otherwise will fall through to
      # return an error message.
      raise if @error_handling == "Raise Error"
    end

    # Return (and escape) the results that were defined in the node.xml
    <<-RESULTS
    <results>
      <result name="Response Body">#{escape(response.nil? ? {} : response.body)}</result>
      <result name="Response Code">#{escape(response_code)}</result>
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
