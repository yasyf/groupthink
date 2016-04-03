class ListController < ApplicationController
  def view
    unless list.ready?
      list.schedule_sync!
      render 'loading'
    end
  end

  def index
  end

  def status
    render json: { ready: list.ready? }
  end

  private

  def list
    @list ||= begin
      List.where(username: params[:username], name: params[:name])
          .first_or_create!
          .tap { |l| raise ActiveRecord::RecordNotFound unless l.exists? }
    end
  end
end
