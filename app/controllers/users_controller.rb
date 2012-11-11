class UsersController < ApplicationController

  #TODO: create rpsec tests for destroy and rwvicw
  def index
    #added the not_deleted method to show users not logically deleted
    #from the database
    @poets = User.not_deleted.page(params[:page]).per(10)
    @deleted_poets = User.deleted
  end

  def show
    @poet = User.find(params[:id])
    redirect_to(poems_path(id: @poet.id))
  end

  def profile
    @poet = current_user
  end

  #TODO: move the destroy and revive methods to a new controller
  #TODO: get working ajax call for destroy and revive
  #using permanent_record with a deleted_at column added to the Users and Poems table
  #this will logically delete the user and the associated poems
  def destroy
    @poet = User.find(params[:id])
    @poet.destroy

    respond_to do |format|
      format.html { redirect_to poets_url }
      format.json { head :ok }
      format.js
    end
  end

  def revive
    @poet = User.find(params[:id])
    @poet.revive
    redirect_to(poets_path)
  end
end
