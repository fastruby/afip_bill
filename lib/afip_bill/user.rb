module AfipBill
  class User
    attr_accessor :company_name, :owner_name, :address, :tax_category

    def initialize(company_name, owner_name, address, tax_category)
      @company_name = company_name
      @owner_name = owner_name
      @address = address
      @tax_category = tax_category
    end
  end
end
