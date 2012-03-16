class Parature
  module Webmocks

    def stub_folder_request(parature, folders_params)
      stub_parature_request(parature, "ArticleFolder", build_folder_response(folders_params))
    end

    def stub_article_request(parature, folder_id, articles_params)
      stub_parature_request(parature, "Article", build_article_response(articles_params), :Folders_id_ => folder_id)
    end

    private

      def build_path(connection, entity)
        "https://#{connection.host}/api/v1/#{connection.account_id}/#{connection.department_id}/#{entity}"
      end

      def stub_parature_request(parature, entity, response_hash, additional_params = {})
        stub_request(:get, build_path(parature.connection, entity)).with(:query => {
          :_output_ => "json", :_token_ => parature.connection.token
        }.merge(additional_params)).to_return(:body => JSON.generate(response_hash))
      end

      def build_folder_response(folders_params)
        folders_params.inject({}) do |hash, params|
          hash["Entities"] ||= {}
          hash["Entities"]["ArticleFolder"] ||= []
          hash["Entities"]["ArticleFolder"] << {
            "@id" => params[:id],
            "Name" => { "#text" => params[:name] }
          }
          hash
        end
      end

      def build_article_response(articles_params)
        articles_params.inject({}) do |hash, params|
          hash["Entities"] ||= {}
          hash["Entities"]["Article"] ||= []
          hash["Entities"]["Article"] << {
            "@id" => params[:id],
            "Question" => { "#text" => params[:question] },
            "Answer" => { "#text" => params[:answer] }
          }
          hash
        end
      end

  end
end
