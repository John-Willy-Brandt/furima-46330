class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :family_name, presence: true,
                          format: { with: /\A[ぁ-んァ-ン一-龥々ーヶヵ]+\z/,
                                    message: 'は全角の漢字・ひらがな・カタカナで入力してください（空白不可）' }

  validates :first_name, presence: true,
                         format: { with: /\A[ぁ-んァ-ン一-龥々ーヶヵ]+\z/,
                                   message: 'は全角の漢字・ひらがな・カタカナで入力してください（空白不可）' }
  validates :family_name_kana, presence: true,
                               format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' }
  validates :birthday, presence: true

  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は半角英数字混合で入力してください' }

  has_many :items
  has_many :purchase_records # ←ここにアソシエーションを記載しているつもり。
end
