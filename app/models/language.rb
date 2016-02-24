class Language < ActiveRecord::Base


  Ruby = {name: :Ruby, lang_id: 1 }
  Javascript = {name: :Javascript, lang_id: 4 }
  CSS = {name: :CSS, lang_id: 3 }
  HTML = {name: :HTML, lang_id: 2 }

  validates :kind, presence:true, uniqueness:true
end
