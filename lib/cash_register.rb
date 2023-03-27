
class CashRegister
  attr_accessor :total, :discount, :items

  def initialize(discount=0)
    @total = 0
    @discount = discount
    @items = []
    @last_transaction = {}
  end

  def add_item(title, price, quantity=1)
    self.total += price * quantity
    quantity.times do
      items << title
    end
    @last_transaction[:title] = title
    @last_transaction[:price] = price
    @last_transaction[:quantity] = quantity
  end

  def apply_discount
    if discount > 0
      self.total = (total * ((100.0 - discount.to_f)/100)).round(2)
      "After the discount, the total comes to $#{total.to_i}."
    else
      "There is no discount to apply."
    end
  end

  def void_last_transaction
    if @last_transaction[:title]
      self.total -= @last_transaction[:price] * @last_transaction[:quantity]
      @last_transaction[:quantity].times do
        items.pop
      end
      @last_transaction = {}
    end
    self.total = 0 if items.empty?
  end
end
