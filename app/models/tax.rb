class Tax < ActiveRecord::Base

  belongs_to :client

  validates :tax_year, uniqueness: { :scope => 'client_id', 
                                      message: "only one tax year per client_id allowed"}

  def self.client_tax_details(client_id)
    where({:client_id => client_id})

  end



end