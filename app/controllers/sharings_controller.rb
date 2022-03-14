class SharingsController < ApplicationController
  def create
    sharing = Sharing.new(sharing_params)
    render json: { sharing: sharing } if sharing.save!
  end

  private

  def sharing_params
    params.require(:sharing).permit(files: [])
  end
end
