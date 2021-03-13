#module API
    #module V1
    module Defaults
        
        extend ActiveSupport::Concern
  
        included do
            format :json
            prefix :api
            default_format :json
            #version "v1", using: :path
            version 'v1', using: :path, vendor: API_VENDOR
         
            formatter :json, Grape::Formatter::ActiveModelSerializers

            error_formatter :json, Grape::Formatter::ActiveModelSerializers

            rescue_from ActiveRecord::RecordNotFound do |e|
                # error_response(message: e.message, status: 404)
                render_error(RESPONSE_CODE[:not_found], I18n.t("errors.#{e.model.to_s.downcase}.not_found"))
            end
          
            rescue_from ActiveRecord::RecordInvalid do |e|
                error_response(message: e.message, status: 422)
            end


          helpers do
            def permitted_params
              @permitted_params ||= declared(params, include_missing: false)
            end
  
            def logger
              Rails.logger
            end

            def render_error(code, message, debug_info = '')
              error!({meta: {code: code, message: message, debug_info: debug_info}}, code)
            end
      
            def render_success(json, extra_meta = {})
              {
                data: json, 
                meta: {code: RESPONSE_CODE[:success], message: "success"}.merge(extra_meta)
              }
            end
          end
  
          
        end
      end
    #end
#  end