module Concerns
  module Findable
   def find_by_name(name)
    all.find do |object|
        object.name == name
   end

   def find_or_create_by_name(name)
    find_by_name(name) || self.create(name)
  end
end