require 'spec_helper'

describe Mbsy::Balance do
  
  let(:resource_prefix) { "#{fake_domain}/balance" }
  let(:existing_customer) { FactoryGirl.create(:ambassador, email: 'ambassador@mbsy.co', first_name: 'test', amount: '0') }
  
  it 'adds to the existing balance' do
    params = { email: existing_customer.email, amount: '10' }
    FakeWeb.register_uri(:get, "#{resource_prefix}/add/?output=json", :body => params)
    expect { 
              Mbsy::Balance.update(params) 
            }.to_change { existing_customer.balance_money }.from(0).to(10)
  end
  
  it 'deducts from the existing balance' do
    params = { email: existing_customer.email, amount: '10' }
    FakeWeb.register_uri(:get, "#{resource_prefix}/subtract/", :body => params)
    
    expect {
              Mbsy::Balance.update(:subtract, email: existing_customer.email, amount: '10') 
            }.to_change { existing_customer.balance_money }.from(0).to(-10)
  end
  
end