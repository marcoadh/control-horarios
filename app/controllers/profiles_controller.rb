class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_profile
  
    def show
    end
  
    def edit
    end
  
    def update
      respond_to do |format|
        if @profile.update(profile_params)
          format.html  { redirect_to(@profile,
                      :notice => 'Se actualizó el perfil.') }
        else
          format.html  { render :action => "edit" }
          format.json  { render :json => @profile.errors,
                      :status => :unprocessable_entity }
        end
      end
    end
  
    private
      def set_profile
        @profile = (current_user.profile ||= Profile.create)
      end
  
      def profile_params 
        params.require(:profile).permit(:nombre, :apellido, :tipo)
      end
      
end