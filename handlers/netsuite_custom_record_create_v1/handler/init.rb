# Require the dependencies file to load the vendor libraries
require File.expand_path(File.join(File.dirname(__FILE__), "dependencies"))

class NetsuiteCustomRecordCreateV1
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

    api_version = "2021_1"
    @api_location = "https://#{@netsuite_environment}.suitetalk.api.netsuite.com/services/NetSuitePort_#{api_version}"

    @attributes = valid_json(@parameters["attributes"])
    @internal_id = @parameters['internal_id']
    @type_id = @parameters["type_id"]

    consumer_key = @info_values["consumer_key"]
    consumer_secret = @info_values["consumer_secret"]
    token_id = @info_values["token_id"]
    token_secret = @info_values["token_secret"]
    api_location = @api_location
    log_level = @debug_logging_enabled ? :debug : :info 

    netsuite_environment = @netsuite_environment.gsub(/-/, "_").upcase
    NetSuite.configure do
      reset!
      
      account netsuite_environment

      api_version api_version
      
      consumer_key consumer_key
      consumer_secret consumer_secret
      token_id token_id
      token_secret token_secret

      log_level log_level

      endpoint api_location
    end
  end

  def execute
    # Initialize return data
    error_message = nil
    error_key = nil
    response_code = nil

    begin
      record = NetSuite::Records::CustomRecord.new
      record.rec_type = NetSuite::Records::CustomRecord.new(internal_id: @internal_id)

      # Add the custom fields.
      record.custom_field_list = {
        :custom_field => @attributes
      }

      puts "Creating custom record." if @debug_logging_enabled
      # Create the custom Record with the add fields.
      response = record.add
    rescue Exception => error
      error_message = error.inspect
      raise error if @error_handling == "Rasie Error"
    end

    # Return (and escape) the results that were defined in the node.xml
    <<-RESULTS
    <results>
      <result name="Success">#{escape(response)}</result>
      <result name="Internal Id">#{escape(record.internal_id)}</result>
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

  def valid_json(json)
      return JSON.parse(json, {:symbolize_names => true})
    rescue JSON::ParserError => e
      return raise "Attributes not valied Json #{e}"
  end
end
