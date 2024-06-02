# 定数
OAUTH_AUTHORIZE_URL = "http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/authorize?client_id=#{Rails.application.credentials.client_id}&response_type=code&redirect_uri=http://localhost:3000/oauth/callback&scope=write_tweet"
