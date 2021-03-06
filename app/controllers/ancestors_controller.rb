class AncestorsController < ApplicationController
  before_action :set_ancestor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_sender

  # GET /ancestors
  # GET /ancestors.json
  def index
    @ancestors = @sender.ancestors.where(user_id: current_user.id)
  end

  # GET /ancestors/1
  # GET /ancestors/1.json
  def show
  end

  # GET /ancestors/new
  def new
    @ancestor = Ancestor.new
  end

  # GET /ancestors/1/edit
  def edit
  end

  # POST /ancestors
  # POST /ancestors.json
  def create
    @ancestor = @sender.ancestors.new(ancestor_params)
    @ancestor.user_id = current_user.id
 
    respond_to do |format|
      if @ancestor.save
        format.html { redirect_to sender_ancestors_path(@sender), notice: 'Ancestor was successfully created.' }
        format.json { render action: 'show', status: :created, location: [@sender, @ancestor] }
      else
        format.html { render action: 'new' }
        format.json { render json: @ancestor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ancestors/1
  # PATCH/PUT /ancestors/1.json
  def update
    respond_to do |format|
      if @ancestor.update(ancestor_params)
        format.html { redirect_to sender_ancestors_path(@sender), notice: 'Ancestor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ancestor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ancestors/1
  # DELETE /ancestors/1.json
  def destroy
    @ancestor.destroy
    respond_to do |format|
      format.html { redirect_to ancestors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ancestor
      @ancestor = Ancestor.find(params[:id])
    end
  
    def set_sender
      @sender = Sender.find(params[:sender_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ancestor_params
      
      params.require(:ancestor).permit(:names, :last_names)
    end
end
