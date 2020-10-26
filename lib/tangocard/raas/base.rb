module Tangocard
  module Raas
    class Base
      include HTTParty
      format :json

      class << self
        def basic_auth_param
          {
            basic_auth: {
              username: Tangocard.configuration.name,
              password: Tangocard.configuration.key
            }
          }
        end

        def headers_param
          { headers: { 'Content-Type' => 'application/json' } }
        end

        def endpoint
          "#{Tangocard.configuration.base_uri}/raas/v2"
        end

        def get_request(path)
          response = Tangocard::Response.new(get("#{endpoint}#{path}", basic_auth_param))

          unless response.success?
            exception = case response.code
                        when 404 then NotFoundException
                        else ResponseException
                        end

            raise exception, response.error_message.to_s
          end

          response.response
        end

        def post_request(path, params)
          post_params = params.deep_transform_keys do |k|
            key = k.to_s.camelize(:lower)
            key.sub!(/Id$/,'ID') if key.match(/Id$/)
            key
          end

          response = Tangocard::Response.new(
            post("#{endpoint}#{path}", { body: post_params.to_json }
              .merge(basic_auth_param.merge(headers_param)))
          )

          unless response.success?
            raise ResponseException, response.error_message.to_s
          end

          response.response
        end
      end
    end
  end
end
