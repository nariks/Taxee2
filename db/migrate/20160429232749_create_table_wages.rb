class CreateTableWages < ActiveRecord::Migration
  def change
  	create_table :wages do |t|
  		t.integer 		:tax_year
  		t.float 			:salary
  		t.float 			:super
  		t.float				:fringe_benefits
  		t.float				:contractor_payments
  		t.float				:ess
  		t.float				:allowances
  		t.float				:apprentice_payments
  		t.float				:exempt_wages
      t.string      :client_id
  	end
  end
end
