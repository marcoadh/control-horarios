class ApplicationController < ActionController::Base
    layout :layout_by_resource

    private
        def layout_by_resource
            # Pregunta si el controlador que se está ejecutando es de devise
            if devise_controller?
                # buscará un layout llamado devise
                "devise"
            else
                "application"
            end
        end
end
