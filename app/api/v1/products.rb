#module API
    module V1
  
        class Products < Grape::API

            include Defaults

            resource :products do
             
        
                #### GET
                desc "Product list",   http_codes: [
                    { code: 200, message: 'success' },
                    { code: RESPONSE_CODE[:forbidden], 
                        message: I18n.t('errors.forbidden') 
                    }
                ]
                    
                get  do                  
                    @products =  Product.all
                    #render json: @products                   
                    #render json: products, status: :ok, each_serializer: API::V1::ProductSerializer , meta: {total: 10}
                    
                    #render_success( products, meta: {total: 10})
                    render json: @products, serializer: API::V1::ProductSerializer, root: 'user', meta: {total: 10}
                    
                    #serialization = ActiveModel::Serializer::CollectionSerializer.new(products, each_serializer: ProdcutsSerializer)

                    #render_success({users: serialization.as_json})
                end
        
        
           
                #### GET ID
                desc 'Get Product',  http_codes: [
                    { code: 200, message: 'success' },
                    { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
                ]
        
                params do
                    requires :id, type: Integer, desc: "Product id"
                end
        
                get ':id' do
                    begin
                        product = Product.find(params[:id])
                        rescue ActiveRecord::RecordNotFound
                        error!({ status: :not_found }, 404)
                    end
                end



        
                
                #### DELETE
                desc 'Delete Product By Id',  http_codes: [
                    { code: 200, message: 'success' },
                    { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
                ]
        
                params do
                    requires :id, type: Integer, desc: "Product id"
                end
        
                delete ':id' do
                    begin
                        product = Product.find(params[:id])
                        { status: :success } if product.delete
                    rescue ActiveRecord::RecordNotFound
                        error!({ status: :error, message: :not_found }, 404)
                    end
                end
        

               
                #### UPDATE
                desc 'Update Product By Id',  http_codes: [
                    { code: 200, message: 'success' },
                    { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
                ]
            
                params do
                    requires :id, type: Integer, desc: "Product id"
                    requires :name, type: String, desc: "Product name"
                    requires :price, type: BigDecimal, desc: "Product price"
                    optional :old_price, type: BigDecimal, desc: "Product old price"
                    requires :short_description, type: String, desc: "Product old price"
                    optional :full_description, type: String, desc: "Product old price"
                end
        
                put ':id' do
                    begin
                        product = Product.find(params[:id])
                        if product.update({
                                            name: params[:name],
                                            price: params[:price],
                                            old_price: params[:old_price],
                                            short_description: params[:short_description],
                                            
                                        })
                        { status: :success }
                        else
                        error!({ status: :error, message: product.errors.full_messages.first }) if product.errors.any?
                        end
                
                        rescue ActiveRecord::RecordNotFound
                            error!({ status: :error, message: :not_found }, 404)
                    end
                end
        
        
           
                #### CREATE 
                desc 'Create new Product', http_codes: [
                    { code: 200, message: 'success' },
                    { code: RESPONSE_CODE[:unprocessable_entity], message: 'Detail error messages' }
                ]
        
                params do
                    requires :name, type: String, desc: "Product name"
                    requires :price, type: BigDecimal, desc: "Product price"
                    optional :old_price, type: BigDecimal, desc: "Product old price"
                    requires :short_description, type: String, desc: "Product old price"         
                end
        
                post do
                    begin
                        product =  Product.create({
                                                    name: params[:name],
                                                    price: params[:price],
                                                    old_price: params[:old_price],
                                                    short_description: params[:short_description],
                                                    
                                                })
                        if product.save
                        { status: :success }
                        else
                        error!({ status: :error, message: product.errors.full_messages.first }) if product.errors.any?
                        end
                        rescue ActiveRecord::RecordNotFound
                            error!({ status: :error, message: :not_found }, 404)
                    end
                end
            
            end
        
            

        end ## class
    end

#end


#desc "Delete Product By Id", {
                #    :notes => <<-NOTE
                #    Delete Product By Id
                #    __________________
                #    NOTE
                #}