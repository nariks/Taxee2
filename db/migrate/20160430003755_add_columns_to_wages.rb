class AddColumnsToWages < ActiveRecord::Migration
  def change
  	add_column :wages, :interstate_wages, :float
  	add_column :wages, :grp_nsw_wages, :float
  	add_column :wages, :grp_interstate_wages, :float
  end
end
