class SearchController < ApplicationController
    before_action :authenticate_user!

    def list
        @lista = Record.porEmpleado(params[:id])
    end

    def calendar
        @lista = Record.porEmpleado(params[:id])
    end
end