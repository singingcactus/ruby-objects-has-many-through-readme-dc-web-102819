class Waiter

  attr_accessor :name, :yrs_experience

  @@all = []

  def initialize(name, yrs_experience)
    @name = name
    @yrs_experience =yrs_experience
    @@all << self
  end

  def self.all
    @@all
  end

  def new_meal(customer, total, tip=0)
    Meal.new(self, customer, total, tip)
  end

  def meals
    Meal.all.select { |meal|
      meal.waiter == self
    }
  end

  def best_tipper
    meals.max { |a, b|
      a.tip <=> b.tip
    }.customer
  end

  def most_frequent_customer
    customer_list = meals.map { |meal|
      meal.customer
    }
    unique_customers = customer_list.uniq

    i = 0
    while i < unique_customers.length
      unique_customers[i][:visits] = customer_list.map { |customer_meal|
        unique_customers[i] == customer_meal
      }.count
      i += 1
    end

    unique_customers.reduce {|max_count, customer|
        max_count[:visits] > customer[:visits] ? max_count : customer
      }
      
  end
end
