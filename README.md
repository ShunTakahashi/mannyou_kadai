# 株式会社万葉様新入社員教育課題

* 株式会社万葉様の新人社員教育課題の仕様を順次実装していく。

## バージョン
Ruby 2.6.3

Rails 6.0.0

PostgreSQL 11.3

### DB情報

* userテーブル

| Column | Type |
|:----:|:----:| 
| id | integer |
| name | string |
| email | string |
|password_digest | string|

* Taskテーブル

| Column | Type |
|:---:|:---:|
| id | integer |
| user_id | bigint |
| label_id | bigint |
| title | string |
| content | text |

* Labelテーブル

| Column | Type |
| :---:|:---:|
| id | integer |
| task_id | bigint |
| label_name | string |

###Herokuへのデプロイ手順

ディレクトリに移動

`$ cd mannyou_kadai`

リポジトリを初期化

`$ git init`

ディレクトリをコミット対象にする

`$ git add .`

コミット

`$ git commit -m "first_commit"`

Herokuを作成

`$ heroku create <アプリ名>`

* <アプリ名>は省略可能。省略するとアプリ名が自動で払い出される
* 払い出されたURLがHerokuアプリのURL、Gitリポジトリとなる

リモートリポジトリの確認

`$ git remote`

`heroku`

herokuと表示されない場合は補足を参照

デプロイ

`$ git push heroku master`

DB移行

`$ heroku run rails db:migrate`

Herokuへアクセスする

`$ heroku open`

* 補足

__git init__ を行う前に __heroku create__ を実行した場合は

リモートリポジトリが自動で登録されないため手動で登録を行う

`git remote add heroku https://git.heroku.com/<herokuアプリ名>.git`

リモートリポジトリの再確認

`$ git remote`

`heroku`

herokuと出力されれば完了