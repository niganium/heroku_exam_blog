class Blog < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :content,    length: { maximum: 140 }  
end
