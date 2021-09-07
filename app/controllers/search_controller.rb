class SearchController < ApplicationController
    before_action :authenticate_user!
    def calendar
        @lista = Record.porEmpleado(params[:id])
        @records = Record.reporte(params[:id])
        respond_to do |format|
            format.html
            format.csv { send_data to_csv(@records), filename: "Reporte de Horas - #{@records.first.employee.nombre}.csv" }
            format.xls
        end
    end

    private
        def to_csv(id)
            attributes = ['Fecha', 'Entrada', 'Salida', 'Sub total de horas']
            CSV.generate do |csv|
                nombre = @records.first
                csv << ["Nombre Completo"]
                csv << [nombre.employee.nombre + ", " + nombre.employee.apellido]
                csv << []
                csv << attributes
                hrs_mes = 0
                @records.each do |record|
                    csv << [record.job_entry.strftime("%d-%m-%Y"), record.job_entry.strftime("%I:%M:%S %p"), record.job_exit.strftime("%I:%M:%S %p"), record.daily_hours.to_f.round(2)]
                    hrs_mes = hrs_mes + record.daily_hours.to_f
                end
                csv << []
                csv << ["Total de Horas : ", hrs_mes.round(2)]
            end
        end
end