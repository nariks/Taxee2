class Client < ActiveRecord::Base
	belongs_to	:user
	has_many		:wages
	has_many  	:taxes

	validates_uniqueness_of :client_id
	# validates :grp_status, acceptance: true


	def self.my_clients(current_user)
		where({user_id: current_user.id})
	end

	def check_grp_status(status)
		if grp_status == status 
			return true 
		else
			return false
		end
	end

	def self.destroy_client_records(c_id)
		client = Client.find_by(:client_id => c_id)
    client.destroy
    wages = Wage.where(:client_id => c_id)
    wages.destroy_all if wages
    taxes = Tax.where(:client_id => c_id)
    taxes.destroy_all if taxes
  end

end

