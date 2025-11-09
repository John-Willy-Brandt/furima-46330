# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
# Table
## Table: users

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### Association

- has_many :items
- has_many :purchase_records


## Table: items

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| item_name            | string     | null: false                    |
| explanation          | text       | null: false                    |
| category_id          | integer    | null: false                    |
| status_id            | integer    | null: false                    |
| delivery_cost_id     | integer    | null: false                    |
| prefecture_id        | integer    | null: false                    |
| delivery_duration_id | integer    | null: false                    |
| price                | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |
### Association

- belongs_to :user
- has_one_attached :image
- has_one :purchase_record

## Table: addresses

| Column | Type      | Options                        |
| ------ | ----------| ------------------------------ |
| zipcode            | string     | null: false |
| prefecture_id      | integer    | null: false |
| city               | string     | null: false |
| address            | string     | null: false |
| address_detail     | string     | null: false |
| building_name      | string     |             |
| tel                | string     | null: false |
| purchase_record    | references | null: false, foreign_key: true  |
### Association

- belongs_to :purchase_record

## Table: purchase_records

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| item        | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |
| address     | references | null: false, foreign_key: true |

- belongs_to :item
- belongs_to :user

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
