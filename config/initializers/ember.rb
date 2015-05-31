EmberCLI.configure do |c|
  # c.app :dog-js, path: '~/gSchoolProjects/projects/dog-js'
  c.app :dog-js, path: Rails.root.join('dog-js').to_s
  c.app :puppifi
end
