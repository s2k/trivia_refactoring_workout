require 'rspec/core/rake_task'

require 'rake/testtask'
Rake::TestTask.new("minitest") do |t|
  t.libs.push "lib"
  t.libs.push "test"
  t.test_files = FileList['test/*_test.rb']
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob("spec/**/*_spec.rb")
end

task default: :spec
