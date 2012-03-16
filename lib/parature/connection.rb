class Parature
  class Connection
    API_VERSION = "v1"
    PROTOCOL = "https"
    attr_reader :host, :account_id, :department_id, :token

    def initialize(options)
      @host = options[:host]
      @account_id = options[:account_id]
      @department_id = options[:department_id]
      @token = options[:token]
    end

    def get(entity, params = {})
      default_params = {:_token_ => @token, :_output_ => "json"}
      response = RestClient.get(path(entity), :params => default_params.merge(params))
      response.gsub!("\xEF\xBB\xBF", '') # Get rid of UTF-8 BOM mark, which Parature adds
      JSON.parse(response)
    end

    private

      def path(entity)
        "#{PROTOCOL}://#{@host}/" + ['api', API_VERSION, @account_id, @department_id, entity] * "/"
      end

  end
end

