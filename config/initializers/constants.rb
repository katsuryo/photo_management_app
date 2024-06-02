# 定数
REDIRECT_URI = "http://localhost:3000/oauth/callback"
OAUTH_AUTHORIZE_URL = "http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/authorize?client_id=#{Rails.application.credentials.client_id}&response_type=code&redirect_uri=#{REDIRECT_URI}&scope=write_tweet"
TOKEN_ENDPOINT_URL = "http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/token"
TWEET_ENDPOINT = "http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/api/tweets"
