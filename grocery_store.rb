require 'colorize'

@grocery_items = [
  {
    id: 1,
    name: "Milk",
    price: 2.00
},
{
  id: 2,
  name: "Banana",
  price: 0.50
},
{
  id:3,
  name: "Cereal",
  price: 3.05
},
{
  id:4,
  name: "Monster",
  price: 1.99
},
{
  id:5,
  name: "24 Pk Water Bottles",
  price: 2.99
},
{
  id:6,
  name: "4k TV",
  price: 89.99
}
]

@my_cart = [
]

@balance = rand(10..100)
@choice_1
@coupon1
@items_total
@continue_1
@newbalance

def separator
  puts " "
end

def welcome
  puts "Welcome to the Grocery Store Menu"
  separator
  menu
end

def menu
  while true
    puts "Please enter:"
    puts "1) Shop"
    puts "2) View Your Cart"
    puts "3) Checkout"
    puts "4) Add grocery inventory item"
    puts "5) Coupons"
    separator

    @cust_select = gets.chomp.to_i

    if @cust_select == 1
      puts "Your available balance is $#{@balance}".colorize(:green)
      separator
      view_items
    elsif @cust_select == 2
      puts "Your available balance is $#{@balance}".colorize(:green)
      separator
      view_cart
    elsif @cust_select == 3
      puts "Your available balance is $#{@balance}".colorize(:green)
      separator
      cart_total
      separator
      puts "Please pay cashier. Thank you for Shopping"

      exit
    elsif @cust_select == 4
      add_item

    elsif @cust_select == 5
      coupon
    else
      puts "Please enter a valid menu option"
      separator
      menu
    end
    

  end
end

def coupon
puts "Please enter one of the following at checkout for a discount!"
puts "1) GROCERY10 for 10%"
puts "2) GROCERY20 for 20%"
separator
menu
end


def view_items
    @grocery_items.each do |item|
      puts "ID: #{item[:id]} #{item[:name]} Price: $#{item[:price]}"
    end
    separator
      puts "Please select ID number to add item to your cart"

  grab_item = gets.chomp.to_i

  @my_cart << grab_item

  puts "Would you like to add more items? (y/n)"

  continue = gets.chomp.to_s
  separator

  if continue == "y"
      view_items
    else
      separator
      menu

  end

end

def cart_total
  @items_total = 0.0
  @my_cart.each do |item|
    @grocery_items.each do |grocery|
      if item == grocery[:id]
        @items_total += grocery[:price]
      end
    end

  end

  puts "Your total is: $#{@items_total.round(2)}"
  separator
  puts "Would you like to enter a Coupon? y or n"
  @choice_1 = gets.chomp
  case @choice_1
  when "y"
    puts "Please enter the coupon code"
    @coupon1 = gets.chomp.to_s
    case @coupon1
    when "GROCERY10"
      puts "Your new total is $#{(@items_total * 0.9).round(2)}".colorize(:green)
      pay
    when "GROCERY20"
      puts "Your new total is $#{(@items_total * 0.8).round(2)}".colorize(:green)
      pay
    else
      puts "Please enter a valid coupon"
      cart_total
    end
  when "n"
    pay
  else
    puts "Please enter y or n"
  end
end

def pay
  if @balance < @items_total
    puts "Sorry, not enough funds to purchase, please remove an item".colorize(:red)
    separator
    remove_item
  elsif @balance >= @items_total
    puts "Do you want to complete this purchase? (y or n)"
      @pay = gets.chomp.to_s
      case @pay
      when "y"
        puts "Thank you for your purchase"
        @newbalance= @balance - @items_total
        puts "Your remaining balance is $#{@newbalance}".colorize(:green)
        @my_cart.clear
        continue_shopping
      when "n"
     continue_shopping
      else
        puts "Please enter y or n"
        pay
      end  
    exit
  end
end

def view_cart
  @my_cart.each do |item|
    @grocery_items.each do |grocery|
      if item == grocery[:id]
        puts grocery[:name]
      end
    end
  end
  if @my_cart.count > 0
    separator
    puts "Choose one of the following:"
    puts "1) Remove an item from Cart"
    puts "2) Clear Cart"
    puts "3) Checkout"
    puts "4) Main Menu"
    continue_1 = gets.chomp.to_i
    if continue_1 == 1
      remove_item
    elsif continue_1 == 2
      @my_cart.clear
      menu
    elsif continue_1 == 3
      cart_total
    elsif continue_1 == 4
      menu
    end
  else
    puts "No items in cart"
  end
 
end

def remove_item
  item_number = 0
  puts "Below is a list of items in your cart:"
  @my_cart.each do |item|
    @grocery_items.each do |grocery|
      if item == grocery[:id]
        item_number += 1
        puts "ID: #{item_number} #{grocery[:name]}"
      end
    end
  end
  puts "Please enter the ID for the item you'd like to remove"

  remove_id = gets.chomp.to_i
  @my_cart.delete_at(remove_id-1)
  menu

end

def add_item

  new_id = @grocery_items.count + 1

  puts "Please enter the new item's name"
  new_item = gets.chomp.to_s

  puts "Please enter the new item's Price"
  new_price = gets.chomp.to_f

  new_hash = {
  id: new_id,
  name: new_item,
  price: new_price
  }

  @grocery_items << new_hash

end

def continue_shopping
  puts "Would you like to continue shopping? y or n"
  @continue_1 = gets.chomp
  case @continue_1
  when "y"
    @balance = @newbalance
    menu
  else
    exit
  end
end



welcome
