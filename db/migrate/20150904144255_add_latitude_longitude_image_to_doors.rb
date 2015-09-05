class AddLatitudeLongitudeImageToDoors < ActiveRecord::Migration
  def change
    add_column :doors, :latitude, :float
    add_column :doors, :longitude, :float
    add_column :doors, :image, :string
  end
end
