require 'spec_helper'
require 'afip_bill/line_item'

describe AfipBill::LineItem do
  subject { described_class }

  let(:item) { AfipBill::LineItem.new('Item', 1, 100) }

  describe '#new' do
    it 'must be created with name, quantity and imp_unitario' do
      item = AfipBill::LineItem.new('Item', 1, 100)

      expect(item).to be_an_instance_of AfipBill::LineItem
    end
  end

  describe 'attributes' do
    it 'has name' do
      expect(item.name).to eq 'Item'
    end

    it 'has quantity' do
      expect(item.quantity).to eq 1
    end

    it 'has imp_unitario' do
      expect(item.imp_unitario).to eq 100
    end
  end
end
