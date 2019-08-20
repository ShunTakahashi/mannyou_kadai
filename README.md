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

