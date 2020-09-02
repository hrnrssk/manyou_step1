# README

### markdown記法でテーブルスキーマを書く
- ModelName:task
- column:name, type:string
- column:detail, type:text
- column:reated_at, type:datetime
- column:updated_at, type:datetime
- column:deadline, type:string
- column:status, type:string
- column:priority, type:string
- column:author, type:string

### Herokuへのデプロイ手順
- 公式サイトにアクセスしてアカウントを作成するhttps://www.heroku.com/
- Herokuをインストールする
```
$ brew tap heroku/brew && brew install heroku
```

- Herokuにログインする
```
$ heroku login
```

- 登録したメールアドレス、パスワードを入力してログインする
- アセットプリコンパイルをする
```
$ rails assets:precompile RAILS_ENV=production
```
- コミットする
```
~/workspace/heroku_test_app (master) $ git add -A
```
```
~/workspace/heroku_test_app (master) $ git commit -m "init"
```
- Herokuに新しいアプリケーションを作成する
```
$ heroku create
```
- Herokuにデプロイする
```
$ git push heroku 【ここにブランチ名を入力】:master
```
