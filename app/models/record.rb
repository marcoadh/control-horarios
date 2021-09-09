class Record < ApplicationRecord
  belongs_to :employee

  def self.porEmpleado(id)
    Record.where("employee_id = #{id}")
  end

  def self.reporte(id)
    Record
          .joins(:employee)
          .where("employee_id = #{id}")
          .order(:job_entry)
  end

  def self.to_csv(employee_id, date_range)
    attributes = ['Fecha', 'Entrada', 'Salida', 'Sub total de horas']

    CSV.generate do |csv|
        nombre = all.first
        csv << ["Nombre Completo"]
        csv << [nombre.employee.nombre + ", " + nombre.employee.apellido]
        csv << []
        csv << attributes
        hrs_mes = 0
        all.each do |record|
            fecha = record.job_entry.strftime("%d-%m-%Y")
            entrada = record.job_entry.strftime("%I:%M:%S %p")
            salida = record.job_exit ? record.job_exit.strftime("%I:%M:%S %p") : "Sigue trabajando"
            horas_diarias = record.daily_hours ? record.daily_hours.to_f.round(2).to_s + " Horas" : "No hay hora"
            csv << [fecha, entrada, salida, horas_diarias]
            hrs_mes = hrs_mes + record.daily_hours.to_f
        end
        csv << []
        if all.length == 1 && !all.first.job_exit
          csv << ["Aún no hay horas acumuladas mensualmente."]
        else
          csv << ["Total de Horas : ", hrs_mes.round(2)]
        end
    end
  end
end
