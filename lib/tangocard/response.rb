module Tangocard
  class Response

    class UnrecognizedReponseException < StandardError; end

    attr_reader :response, :raw_response, :code

    def initialize(raw_response)
      @raw_response = raw_response
      @response = format_response_keys(@raw_response.parsed_response)
      @code = raw_response.code
    end

    def success?
      [200, 201].include?(code)
    end

    def error_message
      safe_response['errors'].map { |e| e['message'] }
    end

    private

    def safe_response
      response || {}
    end

    def format_response_keys(response_data)
      if response_data.is_a?(Hash)
        response_data.deep_transform_keys do |k|
          k.gsub(/\s/, '_').underscore
        end
      elsif response_data.is_a?(Array)
        response_data.collect { |item| format_response_keys(item) }
      else
        raise UnrecognizedReponseException,
              "Unrecognized response: #{response_data}"
      end
    end
  end
end
