class RecordsController < ApplicationController
    layout "publico"
    before_action :set_record, only: [:show, :edit, :update, :destroy]

    def index
    end

    def show
        respond_to do |format|
            format.html
            format.json{render :json => @registro.to_json}
        end
    end

    def new
        @registro = Record.new
    end

    def edit
    end

    def create
        begin
            tipo = record_params['tipo']
            fecha = record_params['fecha']
            codigo_emp = record_params['codigo']

            if tipo == 'entrada'
                #registro = Record.where(job_entry: fecha, employee_id: codigo_emp)
                registro = Record.where("job_entry LIKE '%#{fecha.to_date}%' AND employee_id = #{codigo_emp}")

                if registro.length > 0
                    mensaje = <<END_STR
                    Buen día, #{registro.first.employee.nombre}!!
                    El sistema validó su registro e indica que ya ingresó su entrada a las #{(registro.first.job_entry).strftime("%I:%M:%S %p")} 
                    con la fecha #{(registro.first.job_entry).strftime("%d-%m-%Y")}.
                    No puedes registrarte dos veces en un día.
END_STR
                    raise mensaje
                else
                    @registro = Record.new()
                    @registro.job_entry = fecha
                    @registro.employee_id = codigo_emp
                end
            else
                registro = Record.where("job_exit IS NULL AND employee_id = #{codigo_emp}")
                if registro.length == 0
                    mensaje = <<END_STR
                    No puedes marcar tu salida de trabajo sin antes haber ingresado.
END_STR
                    raise mensaje
                elsif registro.first.job_entry >= fecha
                    mensaje = <<END_STR
                    Tu hora de salida no puede ser antes de la hora de entrada.
END_STR
                    raise mensaje
                else
                    @registro = Record.where("job_exit IS NULL AND employee_id = #{codigo_emp}").take
                    @registro.job_exit = fecha
                    fecha_salida = @registro.job_exit.strftime("%Y-%m-%d %H:%M")
                    fecha_entrada = @registro.job_entry.strftime("%Y-%m-%d %H:%M")
                    @registro.daily_hours = (Time.parse(fecha_salida) - Time.parse(fecha_entrada))/3600
                end
            end
    
            respond_to do |format|
                if @registro.save
                    format.html { redirect_to @registro, notice: "El registro de horario se logró de manera exitosa." }
                    format.json { render :show, status: :created, location: @registro }
                else
                    format.html { render :new, status: :unprocessable_entity }
                    format.json { render json: @registro.errors, status: :unprocessable_entity }
                end
            end
        rescue => exception
            @error = exception
            render template: "records/errors.html.erb"
        end
    end

    def update
    end

    def destroy
    end

    def errors
    end

    private
    def record_params
        params.require(:record).permit(:tipo, :fecha, :codigo)
    end

    def set_record
        @registro = Record.find(params[:id])
    end
end