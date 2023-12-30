class PrototypesController < ApplicationController

  before_action :authenticate_user!
  before_action :move_to_index, except: [:index, :show, :edit]

  def index
    @prototypes = Prototype.all
  end

  def create
    #if Prototype.create(prototype_params)
      #redirect_to root_path
    @create = Prototype.new(prototype_params)
    if @create.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if  prototype.update(prototype_params)
        redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end


  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end