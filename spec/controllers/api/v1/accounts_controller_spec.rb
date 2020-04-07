require 'rails_helper'

describe Accounts, :type => :model do
  let(:customer) { Customer.new(name: 'Julia Ana') }
binding.pry
  it 'creates account with params' do
    expect(Accounts.new(customer: customer.id)).to be_valid
  end

  it 'creates account fail w/o params' do
    expect(Accounts.new).to_not be_valid
  end
end
