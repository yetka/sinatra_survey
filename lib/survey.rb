class Survey < ActiveRecord::Base
  has_many(:questions)
  before_save(:capitalize_name)

private
  def capitalize_name
    capitalize_name = ""
    name_array = self.name.split(" ")
    name_array.map! {|word| word.capitalize}
    name_array.each {|capitalize_word| capitalize_name.concat(capitalize_word.to_s + " ")}
    self.name = capitalize_name.chop()
  end

end
