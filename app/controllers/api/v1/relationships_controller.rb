class Api::V1::RelationshipsController < ApplicationController
  def index
    @relationships = current_user.relationships
    render "index.json.jbuilder"
  end
  
  def update
    relationship_id = params[:id]
    @relationship = Relationship.find_by(id: relationship_id)
    if params[:step_status]
      @relationship.step_status = params[:step_status]
      @relationship.update_step_status
      render "show.json.jbuilder"
    end
  end

  def show
    relationship_id = params[:id]
    @relationship = Relationship.find_by(id: relationship_id)
    render "show.json.jbuilder"
  end
end
