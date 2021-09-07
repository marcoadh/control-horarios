# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: 'admingeo@gmail.com', password: 'admin123', password_confirmation: 'admin123')

Employee.create(nombre: 'Anna Isabel', apellido: 'Alvarez Quispe')
Employee.create(nombre: 'Carlos', apellido: 'Yosa Perez')

agosto_i = Date.new(2021,8).beginning_of_month
agosto_f = Date.new(2021,8).end_of_month

sept_i = Date.new(2021,9).beginning_of_month

(agosto_i..agosto_f).each do |d|
    Record.create(job_entry: "2021-08-#{d.day} 09:00:00", job_exit: "2021-08-#{d.day} 18:00:00", daily_hours: 9.0, employee_id: 1)
end

(sept_i..Date.today).each do |f|
    Record.create(job_entry: "2021-09-#{f.day} 09:00:00", job_exit: "2021-09-#{f.day} 18:00:00", daily_hours: 9.0, employee_id: 2)
end