class ReportsController < ApplicationController
    
    def report
        @employee = Employee.select("*, nombre || ', ' || apellido AS nombre_completo").all
    end

    def export
        @date_range = params[:date_range]
        @employee_id = params[:employee_id].to_i
        @registers = Record.where("employee_id = #{@employee_id} AND job_entry LIKE '%#{@date_range.to_s}%'").order(:job_entry)
        nombre = @registers.first ? @registers.first.employee.nombre : ""
        apellido = @registers.first ? @registers.first.employee.apellido : ""
        nombre_completo = nombre + ' ' + apellido
        name_file = "#{@employee_id}_#{nombre_completo}_#{@date_range}"

        respond_to do |format|
            format.html
            format.csv {
                name_file += ".csv"
                document_csv = @registers.to_csv(params[:employee_id], params[:date_range])
                #original = @registers.first
                #copy = original.dup

                document_var = Document.all


                document_create = Document.new(name_file: name_file)
                document_create.file.attach(io: StringIO.new(document_csv), filename: name_file)
                document_create.save

                
                #copy.file.attach(io: StringIO.new(original.file.download), filename: name_file)
                #send_data @registers.to_csv(params[:employee_id], params[:date_range])
                send_data document_csv
            }
            format.xls
        end
    end
end