require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_secure_password
    has_many :posts
    has_many :shareposts , :through => :sharepoint
end

class Post < ActiveRecord::Base
    belongs_to :user
end

class Sharepost < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
end