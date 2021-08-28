class EmployeesController < ApplicationController
    before_action :authenticate_user!
    # Filtros -  establecemos la categoría solo para -->
    before_action :set_employee, only: [:edit, :update, :destroy]
  
    def index
      @empleados = Employee.all
    end
  
    def show
      
    end
  
    def new
      @empleado = Employee.new
    end
  
    def edit
    end
  
    def create
      @empleado = Employee.new(employee_params)
  
      respond_to do |format|
        if @empleado.save
          format.json { head :no_content }
          format.js
        else
          format.json { render json: @empleado.errors.full_messages, status: unprocessable_entity }
          format.js { render :new }
        end
      end
    end
  
    def update
      respond_to do |format|
        if @empleado.update(employee_params)
          format.json { head :no_content }
          format.js
        else
          format.json { render json: @empleado.errors.full_messages, status: unprocessable_entity }
          format.js { render :edit }
        end
      end
    end
  
    def destroy
      @empleado.destroy
      respond_to do |format|
        format.json { head :no_content }
        format.js
      end
    end
  
    private
      def set_employee
        @empleado = Employee.find(params[:id])
      end
  
      def employee_params
        params.require(:employee).permit(:nombre, :apellido)
      end
  end
  