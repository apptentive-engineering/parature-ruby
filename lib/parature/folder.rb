class Parature
  class Folder
    ENTITY = "ArticleFolder"
    attr_reader :id, :name

    class << self
      def all(connection)
        hash = connection.get(ENTITY)
        hash["Entities"][ENTITY].map { |folder_hash| new(connection, folder_hash) }
      end
    end

    def initialize(connection, hash)
      @connection = connection
      @id = hash["@id"]
      @name = hash["Name"]["#text"]
    end

    def articles
      Article.all(@connection, id)
    end

    def to_s
      "#<Parature::Folder:#{object_id} id: '#{id}', name: '#{name}'>"
    end
  end
end
