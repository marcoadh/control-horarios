class ReportsController < ApplicationController
    
    def report
        @employee = Employee.select("*, nombre || ', ' || apellido AS nombre_completo").all
    end

    def export
        @date_range = params[:date_range]
        @employee_id = params[:employee_id].to_i

        @registers = Record.where("employee_id = #{@employee_id} AND job_entry LIKE '%#{@date_range.to_s}%'").order(:job_entry)
        
        respond_to do |format|
            format.html
            format.csv {send_data @registers.to_csv(params[:employee_id], params[:date_range])}
            format.xls
        end
    end
end