class SharingsController < ApplicationController
  def create
    sharing = Sharing.new(sharing_params)
    render json: { data: SharingSerializer.new(sharing).serialized_data }, status: :ok if sharing.save!
  end

  def show
    raise ActiveRecord::RecordNotFound unless sharing = Sharing.find_by(token: params[:token])

    render json: SharingSerializer.new(sharing).serialized_data
  end

  private

  def sharing_params
    params.require(:sharing).permit(files: [])
  end
end
