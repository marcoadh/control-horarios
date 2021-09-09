class SearchController < ApplicationController
    before_action :authenticate_user!
    def calendar
        @lista = Record.porEmpleado(params[:id])
        respond_to do |format|
            format.html
        end
    end
end