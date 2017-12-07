class ScrapsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_scrap, only: [:show, :edit, :update, :destroy]

  def new
    if params[:bowl_id] && !Bowl.exists?(params[:bowl_id])
      redirect_to bowls_path, alert: "Bowl not found."
    else
      @scrap = Scrap.new(bowl_ids: [params[:bowl_id]])
      binding.pry
    end
    # @bowl = Bowl.find_by(id: params[:bowl_id])
  end

  def create
    if params[:scrap][:bowl_ids]
      @bowl = Bowl.find_by(id: params[:scrap][:bowl_ids][0])
      #binding.pry #unpermitted parameter bowl_ids
      @scrap = @bowl.scraps.build(scrap_params)
    else
      @scrap = Scrap.new(scrap_params)
    end

    if @scrap.save
      redirect_to @scrap
    else
      render :new
    end
  end

  def show
    # redirect_to bowls_path if @scrap.user != current_user
  end

  def index
    @scraps = current_user.scraps.all
    binding.pry
    @bowl = Bowl.find(params[:bowl_id]) if params[:bowl_id]
  end

  def edit
    if params[:bowl_id]
      bowl = Bowl.find_by(id: params[:bowl_id])
      if bowl.nil?
        redirect_to bowls_path, alert: "Bowl not found."
      else
        @scrap = bowl.scraps.find_by(id: params[:id])
        redirect_to bowl_scraps_path(bowl), alert: "Scrap not found." if @scrap.nil?
      end
    else
      @scrap = Scrap.find(params[:id])
    end
  end

  def update
    if @scrap.update(scrap_params)
      @scrap.save
      binding.pry
      redirect_to scrap_path(@scrap)
    else
      binding.pry
      @scrap.restore_attributes(@scrap.errors.keys)
      render :edit
    end
  end

  def destroy
    @scrap.destroy
    redirect_to root_path
  end

  private

  def scrap_params
    params.require(:scrap).permit(:description, :category, :user_id, :bowl_ids => [])
  end

  def set_scrap
    @scrap = Scrap.find(params[:id])
  end

end
