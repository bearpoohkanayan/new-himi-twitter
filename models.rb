require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_secure_password
    has_many :posts
    has_many :shareposts , :through => :sharepoint

    def total_yaba_count
        posts.sum(:yaba)
    end
end

class Post < ActiveRecord::Base
    belongs_to :user
end

class Sharepost < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
end

