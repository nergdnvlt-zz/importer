require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:reference_id) }
    it { should validate_presence_of(:first) }
    it { should validate_presence_of(:last) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:language) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:live) }
    it { should validate_presence_of(:account_id) }
    it { should validate_presence_of(:product_path) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:list_price) }
    it { should validate_presence_of(:interval) }
    it { should validate_presence_of(:interval_length) }
    it { should validate_presence_of(:next_charge_date) }
  end

  describe 'Relationships' do
    it { should belong_to :company }
  end

  describe 'date getter validations' do
    before(:each) do
      @company = create(:company)
    end

    # NEXT CHARGE DATE VALIDATIONS
    it 'supplies the right date format for next charge date' do
      sub = create(:subscription, next_charge_date: '2020-08-27', company: @company)

      expect(sub.next_charge_date).to eq('2020-08-27')
    end

    it 'creates a random date for next_charge_date' do
      sub = create(:subscription, company: @company)

      expect(sub).to be_a(Subscription)
    end

    # TRIAL END DATE VALIDATIONS
    it 'supplies the right date format for trial end date' do
      sub = create(:subscription, trial_end_date: '2020-08-27', company: @company)

      expect(sub.trial_end_date).to eq('2020-08-27')
    end

    it 'doesnt break if trial end date is nil' do
      sub = create(:subscription, trial_end_date: nil, company: @company)

      expect(sub.trial_end_date).nil?
    end

    it 'doesnt break if trial end date is blank' do
      sub = create(:subscription, trial_end_date: '', company: @company)

      expect(sub.trial_end_date).nil?
    end

    it 'creates a random date for trial end' do
      sub = create(:subscription, company: @company)

      expect(sub).to be_a(Subscription)
    end

    # BEGIN DATE VALIDATIONS
    it 'supplies the right date format for begin date' do
      sub = create(:subscription, begin_date: '2020-08-27', company: @company)

      expect(sub.begin_date).to eq('2020-08-27')
    end

    it 'doesnt break if begin date is nil' do
      sub = create(:subscription, begin_date: nil, company: @company)

      expect(sub.begin_date).nil?
    end

    it 'doesnt break if begin date is blank' do
      sub = create(:subscription, begin_date: '', company: @company)

      expect(sub.begin_date).nil?
    end

    it 'creates a random date for begin date' do
      sub = create(:subscription, company: @company)

      expect(sub).to be_a(Subscription)
    end

    # END DATE VALIDATIONS
    it 'supplies the right date format for end date' do
      sub = create(:subscription, end_date: '2020-08-27', company: @company)

      expect(sub.end_date).to eq('2020-08-27')
    end

    it 'doesnt break if end date is nil' do
      sub = create(:subscription, end_date: nil, company: @company)

      expect(sub.end_date).nil?
    end

    it 'doesnt break if end date is blank' do
      sub = create(:subscription, end_date: "", company: @company)

      expect(sub.end_date).nil?
    end

    it 'creates a random date for end date' do
      sub = create(:subscription, company: @company)

      expect(sub).to be_a(Subscription)
    end

    # OTHER DATE VALIDATIONS - FORMAT & POSTGRESQL
    it 'will allow slashes for date' do
      sub = create(:subscription, next_charge_date: '2020/08/27', company: @company)

      expect(sub.next_charge_date).to eq('2020-08-27')
    end

    it 'will not allow different date order for date' do
      sub = build(:subscription, next_charge_date: '08/27/2020', company: @company)

      expect(sub).to_not be_valid
    end
  end
end
