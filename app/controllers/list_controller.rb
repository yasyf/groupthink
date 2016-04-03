class ListController < ApplicationController
  def view
    @list = List.where(username: params[:username], name: params[:name]).first!
  end
end
