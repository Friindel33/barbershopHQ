class CreateBarbers < ActiveRecord::Migration[5.2]
  def change
    create_table :barbers do |t|
      t.text :name
      t.text :nickname

      t.timestamps
    end

    Barber.create :name => 'John the "Razor"', :nickname => 'John_the_Razor'
    Barber.create :name => 'Bobbie Bold', :nickname => 'Bobbie_Bold'
    Barber.create :name => 'Marta the "Scissors"', :nickname => 'Marta_the_Scissors'

  end
end
