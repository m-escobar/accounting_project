require 'rails_helper'

describe Account, :type => :model do
  describe 'create account' do
    let(:customer) { FactoryBot.create(:customer, name: 'Julia Ana') }

    it 'with params' do
      expect(Account.new(customer_id: customer.id)).to be_valid
    end

    it 'fail w/o params' do
      expect(Account.new).to_not be_valid
    end
  end
end
