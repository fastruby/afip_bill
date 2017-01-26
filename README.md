# AfipBill

AfipBill allows you to generate an AFIP bill in PDF format.

## Installation

Include the gem in your Gemfile:

```ruby
gem 'afip_bill'
```

## Setup

In order to have the bills fully complete, you will need to setup some configuration about your business. You can put all of it inside a `initializers/afip_bill.rb` if you want.
```ruby
AfipBill.configuration[:business_name] = "CompanyName"
AfipBill.configuration[:business_address] = "Address 1234"
AfipBill.configuration[:business_start_date] = "01/01/2017"
AfipBill.configuration[:business_cuit] = "1234567890"
AfipBill.configuration[:city] = "Ciudad de Buenos Aires"
AfipBill.configuration[:ingresos_brutos] = "123-456789-0"
AfipBill.configuration[:iva] = "IVA Responsable Inscripto"
AfipBill.configuration[:sale_point] = "0001"

```

## Usage

< explain bravo here >

### Bravo bill

This is an example of a json generated with BRAVO
```ruby
json_bill = {
  "header_result":"A",
  "authorized_on":"20161012105510",
  "detail_result":"A",
  "cae_due_date":"20161022",
  "cae":"66414616381416",
  "iva_id":"03",
  "iva_importe":0.0,
  "moneda":"PES",
  "cotizacion":1,
  "iva_base_imp":300.0,
  "doc_num":"27041233515",
  "cant_reg":"1",
  "cbte_tipo":"01",
  "pto_vta":"0017",
  "concepto":"02",
  "doc_tipo":"80",
  "cbte_fch":"20161012",
  "imp_tot_conc":0.0,
  "imp_op_ex":0.0,
  "imp_trib":0.0,
  "imp_neto":300.0,
  "imp_iva":0.0,
  "imp_total":300.0,
  "cbte_hasta":1,
  "cbte_desde":1,
  "fch_serv_desde":"20161001",
  "fch_serv_hasta":"20161031",
  "fch_vto_pago":"20161012"
}

```

There are three important classes that you need to use. Those are: `AfipBill::User`, `AfipBill::LineItem` and `AfipBill::Generator`.

### AfipBill::User
You should create a new instance of this class to provide some information about the bill. It accepts four params: `Company name`, `Owner name`, `Address`, and `Tax category`. So, you should do something like this:
```ruby
user = AfipBill::User.new("Bill company name",
                          "Bill owner name",
                          "Bill address",
                          "Bill tax category")
```

### AfipBill::LineItem
With this class you can define the line items for your bill. It accepts three params: `Name`, `Quantity`, and `Unit amount`. 
```ruby
item_1 = AfipBill::LineItem.new("Item 1", 1, 100)
item_2 = AfipBill::LineItem.new("Item 2", 1, 120)
...
```

### AfipBill::Generator
This is the main class. Here you will generate the PDF bill. It accepts three params: `the json bill`, `the user`, and `the array of line items`
```ruby
generator = AfipBill::Generator.new(json_bill, user, [item_1, item_2])
```

And finally you can render the pdf by using the method `generate_pdf_string`:
```ruby
respond_to do |format|
  format.pdf { render text: generator.generate_pdf_string }
end
```

## Demo

This is an example of how it looks a bill generated with this gem: < link to a pdf bill here >

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
