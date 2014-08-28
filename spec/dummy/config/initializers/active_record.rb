class ActiveRecord::Base
  cattr_accessor :skip_callbacks if Rails.env.test?
end
