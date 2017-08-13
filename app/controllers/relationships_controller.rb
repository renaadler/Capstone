class RelationshipsController < ApplicationController
  def index
    if current_user
      if current_user.relationships.count > 0
        @relationships = current_user.relationships
        render "index.html.erb"
      else
        flash[:warning] = "You have no connections. Get it going, person."
        redirect_to "/users"
      end
    else
      flash[:warning] = "You need to login. Get it going, person."
      redirect_to "/login"
    end
  end

  def create
    Relationship.create(user_id: current_user.id, connection_id: params[:connection_id], connected_status: "Connected", step_id: 1, step_status: "Not Yet Updated")
    Relationship.create(user_id: params[:connection_id], connection_id: current_user.id, connected_status: "Connected", step_id: 1, step_status: "Not Yet Updated")
    redirect_to "/"
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
