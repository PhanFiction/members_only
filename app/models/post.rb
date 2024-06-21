class Post < ApplicationRecord
  belongs_to :user

  def as_json(options={})
    super({}.merge(options))
  end
end
