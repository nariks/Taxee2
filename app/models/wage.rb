class Wage < ActiveRecord::Base
	belongs_to :client

  validates :tax_year, uniqueness: { :scope => 'client_id', 
                                      message: "only one tax year per client_id allowed"}


	def self.client_tax_details(client_id)
		where({client_id: client_id})
	end

  def self.number_to_currency(num)
    num_no_dot = num.to_s.split('.')
    num_no_dot[0] = "$#{num_no_dot[0].gsub(/\d(?=(...)+$)/, '\0,')}"
    num_no_dot.join(".")
  end

  def self.calc_prt_liability(wage)
    #calculating liable wages
    liable_wages = wage.salary + wage.super + wage.fringe_benefits +
                 wage.contractor_payments + wage.ess + wage.allowances + 
                 wage.apprentice_payments - wage.exempt_wages
               
               

    #calculating the apprentice offset if applicable
    apprentice_offset =  wage.apprentice_payments > 0 ? (wage.apprentice_payments * 0.545) : 0

    #calculating total Australian wages to workout tax threshold
    total_aus_wages = liable_wages + wage.grp_nsw_wages + wage.grp_interstate_wages
              + wage.interstate_wages

    #calculating tax threshold
    if total_aus_wages > liable_wages
      tax_threshold = (liable_wages + wage.nsw_wages)/total_aus_wages * 750000
    elsif total_aus_wages == liable_wages
      tax_threshold = 750000
    end

    #calculating tax liability
    if liable_wages > tax_threshold
      prt_liability = (liable_wages - tax_threshold) * 0.545
    else
      prt_liability = 0
    end

    return prt_liability
  end

end