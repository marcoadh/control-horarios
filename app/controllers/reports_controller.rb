class ReportsController < ApplicationController

    def index
        @records = Record.reporte(params[:id])
        respond_to do |format|
            format.html
        end
    end  
end