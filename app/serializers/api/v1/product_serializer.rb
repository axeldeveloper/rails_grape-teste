module API
  module V1

    class ProductSerializer < ActiveModel::Serializer
        #attributes :id, :name, :price, :short_description
        # attributes :id, :name, :price, :short_description, :created_at, :updated_at
        attributes :name, 
                  :price, 
                  :short_description
        #attribute :token, if: :show_token?  

        def name
          "#{object.name} #{object.short_description}"
        end
    end
  
  end
end