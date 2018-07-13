class UsersController < ApplicationController
before_action :set_user_infomation, only: [:edit, :update]
    def new
        @user = User.new
    end
    
    
    def confirm 
        @user = User.new(user_params)
        render :new if @user.invalid?
    end
    
    
    def create
        @user = User.new(user_params)
        @user.icon.retrieve_from_cache!  params[:cache][:image]
         
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "ユーザー登録が完了しました"
            redirect_to user_path(@user.id)
        else
            render 'new'
        end
    end
    
    
    
    def show
        @user = User.find(params[:id])
        @favorites = @user.favorites
    end
    
    def update
        if @user.update(user_params)
            redirect_to user_path(@user.id), notice: "ユーザー情報を編集しました！"
        else
            render 'edit'
        end
    end


    private
    
    def set_user_infomation
      @user = User.find(params[:id])
    end
    
    def user_params
        params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :icon, :icon_cache)
    end
    
    
    
end
