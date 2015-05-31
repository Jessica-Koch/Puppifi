EmberCLI.configure do |c|
  # c.app :dogs, path: '~/gSchoolProjects/projects/dog-js'
  c.app :dogs, path: Rails.root.join('dog-js').to_s
  c.app :puppifi
end
