require 'spec_helper'
require "afip_bill/check_digit"

describe AfipBill::CheckDigit do
  subject { described_class }

  describe "#generate" do
    context "when the sum of code numbers is even" do
      it "returns the expected checksum" do
        code = "01234567890"

        checksum = subject.new(code).calculate
        expect(checksum).to eq 5
      end

      it "returns the expected checksum" do
        code = "111111111112233334444444444444455555555"

        checksum = subject.new(code).calculate

        expect(checksum).to eq 3
      end
    end

    context "when the sum of code numbers is odd" do
      it "returns the expected checksum" do
        code = "01234567890"

        checksum = subject.new(code).calculate

        expect(checksum).to eq 5
      end

      it "returns the expected checksum" do
        code = "111111111112233334444444444444455555555"

        checksum = subject.new(code).calculate

        expect(checksum).to eq 3
      end
    end
  end
end
