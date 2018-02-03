require 'afip_bill/check_digit'
require 'afip_bill/generator'
require 'afip_bill/line_item'
require 'afip_bill/user'
require 'afip_bill/version'

module AfipBill
  def self.configuration
    @configuration ||= {
      header_business_name: nil,
      business_name: nil,
      business_address: nil,
      business_start_date: nil,
      business_cuit: nil,
      city: nil,
      ingresos_brutos: nil,
      iva: nil,
      sale_point: nil,
    }
  end
end
