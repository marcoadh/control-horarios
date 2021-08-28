class Record < ApplicationRecord
  belongs_to :employee

  def self.buscador(termino)
    Record.where("entrada LIKE ?", "%#{termino}%")
  end

  def self.porEmpleado(id)
  Record.where("employee_id LIKE ?", "#{id}")
  end
end
