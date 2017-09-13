module Shared::Utils
    # validations
    HAS_INTEGERS = /[0-9]/
    HAS_ALPHA = /[A-Za-z]/
    VALID_EMAIL_REGEX = /\A[a-zA-Z0-9][a-zA-Z0-9\+\_\.\-]+@([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.[a-zA-Z]{2,24}\z/
    VALID_PHONE_NUMBER_REGEX = /[0-9]{3}/
    VALID_APIKEY_REGEX = /\A[a-f0-9]{48}\z/
    VALID_INTEGER_REGEX = /\A[0-9]{1,32}\z/
    VALID_TEXT_INPUT_REGEX = /\A[ -~]+\z/
    VALID_PASSWORD_REGEX = VALID_TEXT_INPUT_REGEX && HAS_INTEGERS && HAS_ALPHA

    def test
      puts "test"
    end

    # used numerous times to test if a passed id param is valid.
    def valid_id(id)
      if !id.nil? && id.match(VALID_INTEGER_REGEX)
        return true
      else
        return false
      end
    end

    def parse_json(data)
      begin
        returnable = JSON.parse(data)
      rescue => e
        ERROR_LOGGER.error "[!] Failed. Could not parse JSON from the REST API response. Data: #{data}"
        return false
      end
    end

    def parse_yaml(data)
      begin
        returnable = YAML.load(data)
      rescue => e
        ERROR_LOGGER.error "[!] Failed. Could not parse YAML from the REST API response. Data: #{data}"
        return false
      end
    end

    def parse_base64(data)
      begin
        returnable = Base64.decode64(data)
      rescue => e
        ERROR_LOGGER.error "[!] Failed. Could not parse Base64 from the REST API response. Data: #{data}"
        return false
      end
    end

end
