require 'spec_helper'
require 'afip_bill/line_item'

describe AfipBill::LineItem do
  subject { described_class }

  let(:item) { AfipBill::LineItem.new('Item', 1, 100) }
  let(:item_zero_quantity) { AfipBill::LineItem.new('Item', 0, 100) }
  let(:item_multiple_units) { AfipBill::LineItem.new('Item', 10, 100) }

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

  describe '#imp_total_unitario' do
    it 'should calculate imp_total_unitario for quantity zero' do
      expect(item_zero_quantity.imp_total_unitario).to be_zero
    end

    it 'should calculate imp_total_unitario for quantity one' do
      expect(item.imp_total_unitario).to eq 100
    end

    it 'should calculate imp_total_unitario for quantity greater than one' do
      expect(item_multiple_units.imp_total_unitario).to eq 1000
    end
  end

  describe '#imp_iva' do
    describe 'default IVA (21%)' do
      it 'should calculate imp_iva for quantity zero' do
        expect(item_zero_quantity.imp_iva).to be_zero
      end

      it 'should calculate imp_iva for quantity one' do
        expect(item.imp_iva).to eq 21
      end

      it 'should calculate imp_iva for quantity greater than one' do
        expect(item_multiple_units.imp_iva).to eq 210
      end
    end
  end

  describe '#imp_total_unitario_con_iva' do
    describe 'default IVA (21%)' do
      it 'should calculate imp_total_unitario_con_iva for quantity zero' do
        expect(item_zero_quantity.imp_total_unitario_con_iva).to be_zero
      end

      it 'should calculate imp_total_unitario_con_iva for quantity one' do
        expect(item.imp_total_unitario_con_iva).to eq 121
      end

      it 'should calculate imp_total_unitario_con_iva for quantity greater than one' do
        expect(item_multiple_units.imp_total_unitario_con_iva).to eq 1210
      end
    end
  end
end
