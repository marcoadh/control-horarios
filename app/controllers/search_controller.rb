class SearchController < ApplicationController
    before_action :authenticate_user!
    def calendar
        @lista = Record.porEmpleado(params[:id])
    end
end