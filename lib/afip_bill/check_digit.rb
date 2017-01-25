# Calculates checksum for AFIP bills (dígito verificador)
#
# @param [String]
# @return [Integer]

module AfipBill
  class CheckDigit
    attr_reader :code_array

    def initialize(code)
      @code_array = code.to_s.chars
    end

    def calculate
      step1 = even_index_numbers * 3
      step2 = step1 + odd_index_numbers
      step2_last = step2.to_s[-1].to_i

      step2_last.zero? ? 0 : 10 - step2_last
    end

    private

    def numbers_with_index(parity)
      numbers = code_array.select.each_with_index { |_, i| i.send(parity) }
      numbers.map(&:to_i).inject { |x, sum| x + sum }
    end

    def even_index_numbers
      numbers_with_index(:even?)
    end

    def odd_index_numbers
      numbers_with_index(:odd?)
    end
  end
end
