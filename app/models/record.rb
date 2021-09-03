class Record < ApplicationRecord
  belongs_to :employee

  def self.porEmpleado(id)
    Record.where("employee_id LIKE ?", "#{id}")
  end

  def self.reporte(id)
    Record.joins(:employee).where(employee_id: id).order(:job_entry)
  end

  #def self.to_csv(id)
  #  CSV.generate do |csv|
  #    csv << column_names
  #    
  #    reporte.each do |record|
  #      csv << record.attributes.values_at(*column_names)
  #    end
  #  end
  #end

end
