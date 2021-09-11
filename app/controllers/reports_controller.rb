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
        extension = request.format.symbol
        file = nil

        name_file = "#{@employee_id}_#{nombre_completo}_#{@date_range}.#{extension}"

        if extension = "csv"
            file = @registers.to_csv(params[:employee_id], params[:date_range])
        else
           template = "reports/export.#{extension}"
           layout   = extension == "html"
           file = StringIO.new(render_to_string(template: template,layout: layout, formats: [extension], locals: { :@registers => @registers }))
        end

        #documents = Document.all

        if params[:export].nil?
            @document = Document.find_or_initialize_by(:name_file => name_file)
            @document.file.attach(io: StringIO.new(file), filename: name_file)
            @document.save
        end

        #if documents.length == 0
        #    @document = Document.new(name_file: name_file)
        #    @document.file.attach(io: StringIO.new(file), filename: name_file)
        #    @document.save
        #
        #else
        #    documents.first.destroy
        #    @document = Document.new(name_file: name_file)
        #    @document.file.attach(io: StringIO.new(file), filename: name_file)
        #    @document.save
        #end

        respond_to do |format|
            format.html
            format.csv {send_data file, filename: name_file}
            format.xls
        end
    end
end