# AfipBill

AfipBill allows you to generate an [AFIP](https://www.afip.gob.ar/) bill in PDF format.

The end result will look like this: [bill_sample.pdf](https://github.com/ombulabs/afip_bill/blob/master/bill_sample.pdf)

## Installation

Include the gem in your Gemfile

```ruby
gem 'afip_bill'
```

Install it
```ruby
$ bundle install
```

## Setup

In order to have the bills fully complete, you will need to setup some configuration about your business. If you're in a Rails application you can place that in `config/initializers/afip_bill.rb`

```ruby
AfipBill.configuration[:header_business_name] = "Company Name"
AfipBill.configuration[:business_name] = "CompanyName SRL"
AfipBill.configuration[:business_address] = "Address 1234"
AfipBill.configuration[:business_start_date] = "01/01/2016"
AfipBill.configuration[:business_cuit] = "1234567890"
AfipBill.configuration[:city] = "Ciudad de Buenos Aires"
AfipBill.configuration[:ingresos_brutos] = "123-456789-0"
AfipBill.configuration[:iva] = "IVA Responsable Inscripto"
AfipBill.configuration[:sale_point] = "0001"
```

Also, one of the main things that you need to have, is a JSON for each of your bills.
It must contain at least these attributes:

```ruby
json_bill = {
  cae: "1234567890123",       # CAE number
  cae_due_date: "20171125",   # CAE expiry date
  doc_num: "12345678901",     # CUIT number
  cbte_tipo: "01",            # Bill type (01 = A, 06 = B, 11 = C)
  cbte_fch: "20170125",       # Bill date
  imp_neto: 220.0,            # Net amount
  imp_iva: 46.2,              # IVA amount
  imp_total: 266.2,           # Total amount
  cbte_hasta: 1,              # Voucher number
  fch_serv_desde: "20170101", # Invoiced from
  fch_serv_hasta: "20170131", # Invoiced to
  fch_vto_pago: "20170115"    # CAE expiration date
}.to_json
```

In [OmbuShop](https://www.ombushop.com/), we like to automatically generate this
JSON using [Bravo](https://github.com/leanucci/bravo).

## Usage

There are three important classes that you need to use: `AfipBill::User`,
`AfipBill::LineItem` and `AfipBill::Generator`.

### AfipBill::User

You should create a new instance of this class to provide some information about the bill. It receives four parameters: `Company name`, `Owner name`, `Address`, and `Tax category`.

```ruby
user = AfipBill::User.new("Bill company name",
                          "Bill owner name",
                          "Bill address",
                          "Bill tax category")
```

### AfipBill::LineItem

With this class you can define the line items for your bill. It receives three parameters: `Name`, `Quantity`, and `Unit amount`.

```ruby
item_1 = AfipBill::LineItem.new("Item 1", 1, 100)
item_2 = AfipBill::LineItem.new("Item 2", 1, 120)
...
```

### AfipBill::Generator

This class will generate the PDF bill. It receives three parameters: `the json bill`, `the user`, and `the array of line items` (all the parameters were defined above)

```ruby
generator = AfipBill::Generator.new(json_bill, user, [item_1, item_2])
```

And finally you can render the PDF by using the `generate_pdf_string` method

```ruby
generator.generate_pdf_string
```

Or if you're in a Rails app you can render it like this:
```ruby
respond_to do |format|
  format.pdf { render text: generator.generate_pdf_string }
end
```

## Special Thanks

AfipBill was inspired in code by [nubis](https://github.com/nubis) and [gastonconcilio](https://github.com/gastonconcilio).

Initial development of this gem was sponsored by [OmbuShop](http://www.ombushop.com).

Thank you!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
