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

Record.create(job_entry: '2021-09-02 08:00:00', job_exit: '2021-09-02 18:00:00', daily_hours: 10.0, employee_id: 1)
Record.create(job_entry: '2021-09-03 08:00:00', job_exit: '2021-09-03 19:00:00', daily_hours: 11.0, employee_id: 1)
Record.create(job_entry: '2021-09-01 09:00:00', job_exit: '2021-09-01 16:00:00', daily_hours: 7.0, employee_id: 2)
Record.create(job_entry: '2021-09-03 09:04:00', job_exit: '2021-09-03 17:07:00', daily_hours: 8.05, employee_id: 2)