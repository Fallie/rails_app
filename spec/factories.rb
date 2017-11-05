FactoryBot.define do
    factory :appointment do
      appointment_time "2017-11-05 13:09:35"
    end

    factory :test_user, :class => User do
      name 'test'
      email 'test@gmail.com'
      password '123'
      password_confirmation '123'
      role 'patient'
      phone_number '0445555555'
      location '1 Park St, Docklands, VIC'
      postcode '3009'
    end

    factory :second_test_user, :class => User do
      id 2
      name 'test'
      email 'test@gmail.com'
      password '123'
      password_confirmation '123'
      role 'patient'
      phone_number '0445555555'
      location '1 Park St, Docklands, VIC'
      postcode '3009'
    end



end