require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_secure_password
    has_many :posts
    has_many :exchange_posts
    has_many :exchanged_posts, through: :exchange_posts, source: :post
    
    def total_yaba_count    
        posts.sum(:yaba)
    end
end

class Post < ActiveRecord::Base
    belongs_to :user
    has_many :exchange_posts
    has_many :exchanged_by_users, through: :exchange_posts, source: :user
end

class ExchangePost < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
end
