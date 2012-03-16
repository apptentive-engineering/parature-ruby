class Parature
  class Article
    ENTITY = "Article"
    attr_reader :id, :question, :answer, :created_at, :updated_at

    class << self
      def all(connection, folder_id)
        hash = connection.get(ENTITY, :Folders_id_ => folder_id)
        hash["Entities"][ENTITY].map { |article_hash| new(connection, article_hash) }
      end
    end

    def initialize(connection, hash)
      @connection = connection
      @id = hash["@id"]
      @question = hash["Question"].andand["#text"]
      @answer = hash["Answer"].andand["#text"]
      created_at_string = hash["Date_Created"].andand["#text"]
      updated_at_string = hash["Date_Updated"].andand["#text"]
      @created_at = Time.parse(created_at_string) if created_at_string
      @updated_at = Time.parse(updated_at_string) if updated_at_string
    end

    def to_s
      "#<Parature::Article:#{object_id} id: '#{id}'>"
    end
  end
end
