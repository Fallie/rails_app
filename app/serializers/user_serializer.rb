class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at, :role, :location, :postcode, :phone_number
end
