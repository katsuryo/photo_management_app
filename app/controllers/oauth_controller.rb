require 'net/http'

class OauthController < ApplicationController
  before_action :authenticate_user
  
  def callback
    code = params[:code]
    client_id = Rails.application.credentials.client_id
    client_secret = Rails.application.credentials.client_secret
    redirect_uri = REDIRECT_URI

    uri = URI(TOKEN_ENDPOINT_URL)
    response = Net::HTTP.post_form(uri, {
      grant_type: 'authorization_code',
      code: code,
      redirect_uri: redirect_uri,
      client_id: client_id,
      client_secret: client_secret
    })

    result = JSON.parse(response.body)
    access_token = result["access_token"]

    # 取得したアクセストークンをsessionに保存
    session[:access_token] = access_token

    redirect_to photos_path
  end
end
