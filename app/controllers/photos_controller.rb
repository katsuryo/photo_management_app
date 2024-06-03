require 'net/http'

class PhotosController < ApplicationController
  before_action :authenticate_user
  UPLOAD_OBJ = "photos"

  def index
    @photos = @current_user.photos.order(created_at: :desc)
  end

  def new
  end

  def create
    if params_missing?
      render :new, status: :unprocessable_entity
      return
    end

    # ファイルの拡張子を取得
    extension = File.extname(params[:image].original_filename)

    # 拡張子がjpgまたはpngであることを確認
    unless valid_extension?(extension)
      flash[:alert] = "・jpgかpngのファイルを使用してください"
      render :new, status: :unprocessable_entity
      return
    end

    # 画像ファイルアップロード
    filename = ImageUploaderService.new(params[:image], UPLOAD_OBJ, extension).call
    image_url = File.join(Rails.application.credentials.IMAGE_BASE_URL + UPLOAD_OBJ, filename)
    
    photo = @current_user.photos.create(title: params[:title], image: image_url)

    if photo
      redirect_to photos_path, notice: "・登録に成功しました"
    else
      flash[:alert] = "・登録できませんでした"
      render :new, status: :unprocessable_entity
    end
  rescue => e
    flash[:alert] = "・システムエラーが発生しました"
    render :new, status: :unprocessable_entity
  end

  def tweet
    photo = Photo.find(params[:id])
    access_token = session[:access_token]
    
    if access_token
      response = post_tweet(photo, access_token)

      if response.code.to_i == 201
        redirect_to photos_path, notice: "ツイートが投稿されました"
      else
        redirect_to photos_path, alert: "ツイートの投稿に失敗しました"
      end
    else
      redirect_to photos_path, alert: "アクセストークンがありません"
    end
  end

  private

    def params_missing?
      error_messages = []
      if params[:title].blank?
        error_messages << "・タイトルを入力してください"
      elsif params[:title].length > 30
        error_messages << "・タイトルは30文字以内にしてください"
      end

      if params[:image].blank?
        error_messages << "・画像ファイルを選択してください"
      end

      unless error_messages.empty?
        flash[:alert] = error_messages.join("<br>")
        return true
      end
      false
    end

    def valid_extension?(extension)
      %w[.jpg .jpeg .png].include?(extension)
    end

    def post_tweet(photo, access_token)
      uri = URI.parse(TWEET_ENDPOINT)
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request["Authorization"] = "Bearer #{access_token}"
      request.body = {
        text: photo.title,
        url: photo.image
      }.to_json

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    end
end
