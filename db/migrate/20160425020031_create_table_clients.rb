class CreateTableClients < ActiveRecord::Migration
  def change
  	create_table :clients do |t|
  		t.string 	:client_id
  		t.string 	:client_name
  		t.string 	:grp_status
  		t.integer 	:grp_members
  		t.string	:user_id
  	end
  end
end
