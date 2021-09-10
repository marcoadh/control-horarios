class DocumentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_employee, only: [:edit, :update, :destroy]
    def index
        @documents = Document.all
    end
    
    def show
    end

    def create
    end

    def update
    end

    def edit
    end

    def destroy
        @document.destroy
    end
  
    private
      def set_document
        @document = Document.find(params[:id])
      end
end