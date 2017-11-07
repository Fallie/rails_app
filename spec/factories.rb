FactoryBot.define do


    factory :test_appointment, :class => Appointment do

      trait :appointment_time do
        date '11/09/2017'
        hour '16'
        min '00'
      end

      trait :duration do
        hour '0'
        min '1800'
      end
      doctor_id 3
      appointment Appointment.new
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
      name 'test2'
      email 'test2@gmail.com'
      password '123'
      password_confirmation '123'
      role 'patient'
      phone_number '0445555555'
      location '1 Park St, Docklands, VIC'
      postcode '3009'
    end

    factory :third_test_user, :class => User do
      id 3
      name 'test3'
      email 'test3@gmail.com'
      password '123'
      password_confirmation '123'
      role 'doctor'
      phone_number '0445555555'
      location '1 Park St, Docklands, VIC'
      postcode '3009'
    end



end