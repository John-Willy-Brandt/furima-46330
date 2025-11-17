FactoryBot.define do
  factory :user do
    nickname          { 'テスト太郎' }
    email             { Faker::Internet.email }
    password          { 'a1b2c3' }
    password_confirmation { password }
    family_name       { '山田' }
    first_name        { '太郎' }
    family_name_kana  { 'ヤマダ' }
    first_name_kana   { 'タロウ' }
    birthday          { '1990-01-01' } # date型なら Date.new(1990,1,1) でもOK
  end
end
