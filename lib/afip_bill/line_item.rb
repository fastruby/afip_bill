module AfipBill
  class LineItem
    attr_reader :name, :quantity, :imp_unitario
    IVA = 21.freeze

    def initialize(name, quantity, imp_unitario)
      @name = name
      @quantity = quantity
      @imp_unitario = imp_unitario
    end

    def imp_total_unitario
      quantity * imp_unitario
    end

    def imp_iva
      imp_total_unitario * IVA / 100
    end

    def imp_total_unitario_con_iva
      imp_total_unitario + imp_iva
    end
  end
end
