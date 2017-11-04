FactoryBot.define do
    factory :test_user, :class => User do
      name 'test'
      email 'test@gmail.com'
      password '123'
      password_confirmation '123'
      role 'patient'
    end
end