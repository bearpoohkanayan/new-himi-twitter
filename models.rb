require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_secure_password
    has_many :shared_posts , through: :share_post
    has_many :posts

    def total_yaba_count    
        posts.sum(:yaba)
    end
end

class Post < ActiveRecord::Base
    has_many :shared_users, through: :share_post
    belongs_to :user
end

class SharePost < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
end

