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
end
