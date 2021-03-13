require 'grape'
require 'grape-swagger' 

module V1
  
    class Base < Grape::API
        
        mount V1::Products

        add_swagger_documentation  base_path: '/',
            hide_documentation_path: true,
            api_version: "v1", 
            mount_path: "/api/v1/swagger_doc",
            doc_version: '0.0.1',
            hide_format: true,
            info: {
                title: "API Rails para Diversão",
                description: "A description of the API.",
                contact_name: "Axel Alexander",
                contact_email: "axel_nomore@hotmail.com",
                contact_url: "Contact URL",
                license: "The name of the license.",
                license_url: "www.The-URL-of-the-license.org",
                terms_of_service_url: "www.The-URL-of-the-terms-and-service.com",
            }
     
    end
end