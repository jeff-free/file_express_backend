class SharingSerializer < SimpleDelegator
  def serialized_data
    {
      data: {
        token: token,
        files: files_hash
      }
    }.to_json
  end

  private

  def files_hash
    files.map do |f|
      { filename: f.filename,
        url: Rails.application.routes.url_helpers.rails_blob_url(f, host: 'localhost:3000') }
    end
  end
end
