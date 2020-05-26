class CreateBarbers < ActiveRecord::Migration[5.2]
  def change
    create_table :barbers do |t|
      t.text :name

      t.timestamps
    end

    Barber.create :name => 'John the "Razor"'
    Barber.create :name => 'Bobbie Bold'
    Barber.create :name => 'Marta the "Scissors"'


  end
end
