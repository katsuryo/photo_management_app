class ImageUploaderService
  
  def initialize(image, upload_obj, extension)
    @image = image
    @upload_obj = upload_obj
    @extension = extension
  end

  def call
    upload_dir = Rails.root.join('public', @upload_obj).to_s
    # upload先ディレクトリ作成
    Dir.mkdir(upload_dir) unless Dir.exist?(upload_dir)

    # 保存先のファイルパスを決定
    filename = SecureRandom.uuid + @extension
    filepath = File.join(upload_dir, filename)

    # ファイルを保存
    File.open(filepath, 'wb') do |file|
      file.write(@image.read)
    end

    # 保存したファイル名を返却
    filename
  end
end