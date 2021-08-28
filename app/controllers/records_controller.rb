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
        if record_params['tipo'] == 'entrada'
            @registro = Record.new()
            @registro.job_entry = record_params['fecha']
            @registro.employee_id = record_params['codigo']
        else
            @registro = Record.where("employee_id=#{record_params['codigo']} AND job_entry<'#{record_params['fecha']}' AND job_exit IS NULL").take
            @registro.job_exit = record_params['fecha']
            @registro.daily_hours = (Time.parse(@registro.job_exit.strftime("%Y-%m-%d %H:%M")) - Time.parse(@registro.job_entry.strftime("%Y-%m-%d %H:%M")))/3600
        end

        respond_to do |format|
            if @registro.save
                format.html { redirect_to @registro, notice: "" }
                format.json { render :show, status: :created, location: @registro }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @registro.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
    end

    def destroy
    end

    private
    def record_params
        params.require(:record).permit(:tipo, :fecha, :codigo)
    end

    def set_record
        @registro = Record.find(params[:id])
    end
end