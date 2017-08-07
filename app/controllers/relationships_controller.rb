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
    # @relationship = current_user.relationships(id: params[:id])
    render "show.html.erb"
  end
end
