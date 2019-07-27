module MusicSocialNetwork
  module RegistrationsControllerDecorator
    def create
      @user = user.new(user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to new_user_session_path, notice: 'user was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to new_user_session_path, notice: 'user was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
  end
end

Devise::RegistrationsController.prepend MusicSocialNetwork::RegistrationsControllerDecorator
