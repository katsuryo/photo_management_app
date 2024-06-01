class PhotosController < ApplicationController
  before_action :authenticate_user
  UPLOAD_OBJ = "photos"

  def index
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
    unless %w[.jpg .jpeg .png].include?(extension.downcase)
      flash[:alert] = "・jpgかpngのファイルを使用してください"
      render :new, status: :unprocessable_entity
      return
    end

    # 画像ファイルアップロード
    filename = ImageUploaderService.new(params[:image], UPLOAD_OBJ, extension).call
    image_url = File.join(Rails.application.credentials.IMAGE_BASE_URL + UPLOAD_OBJ, filename)
    
    photo = @current_user.photos.create(title: params[:title], image: image_url)

    if photo
      redirect_to photos_path
    else
      flash[:alert] = "・登録できませんでした"
      render :new, status: :unprocessable_entity
    end
  rescue => e
    flash[:alert] = "・システムエラーが発生しました"
    render :new, status: :unprocessable_entity
  end

  private

    def params_missing?
      error_messages = []
      if params[:title].blank?
        error_messages << "・タイトルを入力してください"
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
end
