require "json"
require "date"
require "afip_bill/check_digit"
require "barby/barcode/code_25_interleaved"
require "barby/outputter/html_outputter"
require "pdfkit"

module AfipBill
  class Generator
    attr_reader :afip_bill, :bill_type, :user, :line_items, :header_text

    HEADER_PATH = File.dirname(__FILE__) + '/views/shared/_factura_header.html.erb'.freeze
    FOOTER_PATH = File.dirname(__FILE__) + '/views/shared/_factura_footer.html.erb'.freeze
    BRAVO_CBTE_TIPO = { "01" => "Factura A", "06" => "Factura B" }.freeze
    IVA = 21.freeze

    def initialize(bill, user, line_items = [], header_text = 'ORIGINAL')
      @afip_bill = JSON.parse(bill)
      @user = user
      @bill_type = type_a_or_b_bill
      @line_items = line_items
      @template_header = ERB.new(File.read(HEADER_PATH)).result(binding)
      @template_footer = ERB.new(File.read(FOOTER_PATH)).result(binding)
      @header_text = header_text
    end

    def type_a_or_b_bill
      BRAVO_CBTE_TIPO[afip_bill["cbte_tipo"]][-1].downcase
    end

    def barcode
      @barcode ||= Barby::Code25Interleaved.new(code_numbers)
    end

    def generate_pdf_file
      tempfile = Tempfile.new("afip_bill.pdf")

      PDFKit.new(template).to_file(tempfile.path)
    end

    def generate_pdf_string
      PDFKit.new(template).to_pdf
    end

    private

    def bill_path
      File.dirname(__FILE__) + "/views/bills/factura_#{bill_type}.html.erb"
    end

    def code_numbers
      code = code_hash.values.join("")
      last_digit = CheckDigit.new(code).calculate
      result = "#{code}#{last_digit}"
      result.size.odd? ? "0" + result : result
    end

    def code_hash
      {
        cuit: afip_bill["doc_num"].tr("-", "").strip,
        cbte_tipo: afip_bill["cbte_tipo"],
        pto_venta: AfipBill.configuration[:sale_point],
        cae: afip_bill["cae"],
        vto_cae: afip_bill["fch_vto_pago"]
      }
    end

    def template
      ERB.new(File.read(bill_path)).result(binding)
    end
  end
end
