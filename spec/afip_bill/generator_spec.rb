require "spec_helper"
require "afip_bill/generator"
require "afip_bill/line_item"
require "afip_bill/user"

describe AfipBill::Generator do
  subject { described_class }

  let(:user) do
    AfipBill::User.new("OmbuShop", "John Snow", "Winterfell 123",
                       "Consumidor Final")
  end
  let(:bill_path) { File.expand_path("../../support/#{type}.json", __FILE__) }
  let(:bill) { File.read(bill_path) }
  let(:item_1) { AfipBill::LineItem.new("Item 1", 1, 100) }
  let(:item_2) { AfipBill::LineItem.new("Item 2", 1, 100) }

  let(:pdf_file) { subject.new(bill, user, [item_1, item_2]).generate_pdf_file }
  let(:pdf_string) { subject.new(bill, user, [item_1, item_2]).generate_pdf_string }

  before do
    AfipBill.configuration[:header_business_name] = "OmbuShop"
    AfipBill.configuration[:business_name] = "OmbuShop SRL"
    AfipBill.configuration[:business_address] = "Av Juan B. Justo 1500"
    AfipBill.configuration[:business_start_date] = "01/01/1900"
    AfipBill.configuration[:business_cuit] = "30112233445"
    AfipBill.configuration[:city] = "Ciudad de Buenos Aires"
    AfipBill.configuration[:ingresos_brutos] = "901-111111-4"
    AfipBill.configuration[:iva] = "IVA Responsable Inscripto"
    AfipBill.configuration[:sale_point] = "005"
  end

  describe "generate_pdf" do
    context "Bill type A" do
      let(:type) { "type_a" }

      it "has the 'magic number' that identify a PDF file" do
        expect(pdf_file.readpartial(4)).to eq "%PDF"
        expect(pdf_string[0..3]).to eq "%PDF"
      end
    end

    context "Bill type B" do
      let(:type) { "type_b" }

      it "has the 'magic number' that identify a PDF file" do
        expect(pdf_file.readpartial(4)).to eq "%PDF"
        expect(pdf_string[0..3]).to eq "%PDF"
      end
    end
  end
end
