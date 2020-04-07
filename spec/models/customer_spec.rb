require 'rails_helper'

describe Customer, :type => :model do
  it 'creates customer with params' do
    expect(Customer.new(name: 'Julia Ana')).to be_valid
  end

  it 'creates customer fail w/o params' do
    expect(Customer.new).to_not be_valid
  end
end
