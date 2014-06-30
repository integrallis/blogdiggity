Fabricator(:contributor, class_name:  Blogdiggity::Contributor) do
  name { Faker::Name.name }
end
