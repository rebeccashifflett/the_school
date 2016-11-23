require 'rails_helper'

RSpec.describe School, type: :model do
  let(:school) { School.create(name: 'schoo', students: 11, open: true) }
   #let(:school) { FactoryGirl.create(:school)}

  describe 'validations' do
    subject { School.create(name: 'test', open: true) }
    it { should validate_uniqueness_of(:name) }

    it { should validate_presence_of(:name) }
    it do
      should validate_inclusion_of(:open).
        in_array([true, false])
    end
  end

end
