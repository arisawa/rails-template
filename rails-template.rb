gem "therubyracer", platforms: :ruby
gem "unicorn"
gem "maruku"
gem "iconv"
gem "twitter-bootstrap-rails", git: "https://github.com/seyhunak/twitter-bootstrap-rails.git", branch: "bootstrap3"

gem_group :deploy do
  gem "capistrano"
  gem "capistrano-rbenv"
  gem "capistrano-bundler"
  gem "capistrano-rails"
end

gem_group :development, :test do
  gem "rspec-rails", "~> 3.0"
  gem "guard-rails"
  gem "guard-bundler"
  gem "guard-rspec"
  gem "terminal-notifier-guard"
  gem "quiet_assets"
  gem "rails-erd"
end

gem_group :development do
  gem "pry-rails"
  gem "better_errors"
  gem "binding_of_caller"
  gem "meta_request"
  gem "pry-byebug"
  gem "pry-stack_explorer"
end

gem_group :test do
  gem "webmock"
  gem "factory_girl_rails", "~> 4.0"
  gem "timecop"
end

run "bundle install"

file 'Guardfile', <<-EOF
guard :bundler do
  watch('Gemfile')
end

guard 'rails' do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

guard :rspec, cmd: 'spring rspec -f doc' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }

  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^spec/factories/(.+)\.rb$})                { 'spec/factories_spec.rb' }
  watch(%r{^spec/support/(.+)\.rb$})                  { 'spec' }
  watch('config/routes.rb')                           { 'spec/routing' }
  watch('app/controllers/application_controller.rb')  { 'spec/controllers' }
end
EOF

git :init
git add: "."
git commit: "-m 'rails new'"
