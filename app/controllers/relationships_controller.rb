class RelationshipsController < ApplicationController
  def index
    if current_user
      @relationships = current_user.relationships.all
      render "index.html.erb"
    else
      flash[:warning] = "You have no connections. Get it going, person."
      redirect_to "/login"
    end
  end

  def show
    # current_user
    relationship_id = params[:id]
    @relationship = Relationship.find_by(id: relationship_id)
    render "show.html.erb"
  end

  def update
    relationship_id = params[:id]
    @relationship = Relationship.find_by(id: relationship_id)
    @relationship.step_status = params[:step_status]
    @relationship.update_step_status
    if 
      @relationship.save
      flash[:success] = "Status Changed!"
      redirect_to "/relationships/#{@relationship.id}"
    else
      flash[:warning] = "Unable to update."
      render "show.html.erb"
    end
  end
end
