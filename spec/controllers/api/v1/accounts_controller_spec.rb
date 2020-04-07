require 'rails_helper'
require 'pry'

describe Api::V1::AccountsController, :type => :controller do
  describe 'GET create' do
    it 'create account' do
      params = {:account_name=>'Julia Ana', :initial_amount=>20000}

      post :create, params: params
      result = JSON.parse response.body

      expect(result['account_id']).to be_present
      expect(result['token']).to be_present
    end
  end
end
