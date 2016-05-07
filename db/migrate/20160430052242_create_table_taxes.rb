class CreateTableTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
      t.float       :prt_liability
      t.integer     :tax_year
      t.float       :penalty_tax, default: 0
      t.float       :interest, default: 0
      t.string      :client_id
    end
  end
end
