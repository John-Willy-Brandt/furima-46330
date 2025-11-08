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
| birthday           | string | null: false |

### Association

- has_many :items
- has_many :purchases


## Table: items

| Column            | Type       | Options     |
| ----------------- | ---------- | ----------- |
| vender_id         | references | null: false, foreign_key: true |
| image             | string     | null: false |
| item_name         | string     | null: false |
| explanation       | string     | null: false |
| category          | string     | null: false |
| status            | string     | null: false |
| delivery_cost     | string     | null: false |
| delivery_region   | string     | null: false |
| delivery_duration | string     | null: false |
| price             | integer    | null: false |

### Association

- belongs_to :users
- has_one :purchases

## Table: purchases

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| buyer_id          | references | null: false, foreign_key: true |
| zipcode           | string     | null: false |
| prefecture        | string     | null: false |
| city              | string     | null: false |
| address           | string     | null: false |
| building_name1    | string     | null: false |
| building_name2    | string     |             |
| tel               | string     | null: false |

### Association

- belongs_to :users
- belongs_to :items


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
