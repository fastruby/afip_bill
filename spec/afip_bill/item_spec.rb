require 'spec_helper'
require 'afip_bill/line_item'

describe AfipBill::LineItem do
  subject { described_class }

  describe '#new' do
    it 'must be created with name, quantity and imp_unitario' do
      item = AfipBill::LineItem.new('Item', 1, 100)

      expect(item).to be_an_instance_of AfipBill::LineItem
    end
  end
end
