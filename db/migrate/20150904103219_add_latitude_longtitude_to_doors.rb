class AddLatitudeLongtitudeToDoors < ActiveRecord::Migration
  def change
    add_column :doors, :latitude, :float
    add_column :doors, :longtitude, :float
  end
end
