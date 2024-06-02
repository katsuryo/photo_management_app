# ユーザーデータを作成
2.times do |n|
  User.create!(
    username: "test#{n + 1}",
    password: "password#{n + 1}"
  )
end
