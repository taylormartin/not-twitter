RSpec.configure do |config|
  # enables `create :user` instead of `FactoryGirl.create :user`
  config.include FactoryGirl::Syntax::Methods
end
