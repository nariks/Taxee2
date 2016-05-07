class WagesController < ApplicationController

	#Route to show wages details entry form
	get '/client/new/wages/:id' do
		@client = Client.find_by(:client_id => params[:id])
		erb :'/users/wages'

	end

	#route to accept wage details for client, calculate tax liability and update in tax_details table
	post '/client/new/wages/:id' do
		
		@wages = Wage.create(		:tax_year => params[:tax_year],
														:salary => params[:salary], 
		                        :super => params[:super], 
		                        :fringe_benefits => params[:fringe_benefits], 
		                        :contractor_payments => params[:contractor_payments],
		                        :ess => params[:ess], 
		                        :allowances => params[:allowances], 
		                        :apprentice_payments => params[:apprentice_payments],
		                        :exempt_wages => params[:exempt_wages],
		                        :interstate_wages => params[:interstate_wages],
		                        :grp_nsw_wages => params[:grp_nsw_wages],
		                        :grp_interstate_wages => params[:grp_interstate_wages],
		                        :client_id => params[:client_id]
		                    )

		if @wages.save
			
			prt_liability = Wage.calc_prt_liability(@wages)
			penalty_tax = 0
    	interest = 0 
			

			#update tax_details in the tax_details table by creating a new record
			@tax = Tax.create(:tax_year => params[:tax_year],
															:prt_liability => prt_liability,
															:client_id => params[:client_id],
															:penalty_tax => penalty_tax,
															:interest => interest
							)
			redirect "/sessions/tax_details/#{@tax.client_id}"
		else
			redirect "/client/new/wages/#{params[:id]}"
		end
	end

	#Route to display tax_details for a client
	get '/sessions/tax_details/:id' do

		# @tax = Client.find_by(:user_id => current_user.id)
		@tax_details = Tax.client_tax_details(params[:id])
		@client = Client.find_by(:client_id => @tax_details.first.client_id)
		erb :'users/tax_details'

	end

	get '/client/edit/wages/:id/:year' do
    @wage = Wage.find_by(:client_id => params[:id], :tax_year => params[:year])
    if @wage
    	@client = Client.find_by(:client_id => @wage.client_id)
    	erb :'users/wage_edit'
    else
    	redirect "/client/new/wages/#{params[:id]}"
    end
  end

  post '/client/edit/wages/:id' do
  	wage = Wage.find_by(:client_id => params[:id])
  	if wage.update_attributes( :salary => params[:salary], 
	                  :super => params[:super], 
	                  :fringe_benefits => params[:fringe_benefits], 
	                  :contractor_payments => params[:contractor_payments],
	                  :ess => params[:ess], 
	                  :allowances => params[:allowances], 
	                  :apprentice_payments => params[:apprentice_payments],
	                  :exempt_wages => params[:exempt_wages],
	                  :interstate_wages => params[:interstate_wages],
	                  :grp_nsw_wages => params[:grp_nsw_wages],
	                  :grp_interstate_wages => params[:grp_interstate_wages]
		                )

  	
			
			prt_liability = Wage.calc_prt_liability(wage)
			penalty_tax = 0
    	interest = 0 
			

			#update tax_details in the tax_details table by creating a new record
			@tax = Tax.find_by(:tax_year => params[:tax_year], :client_id => params[:id])
			@tax.update_attributes( 
														 :prt_liability => prt_liability,
														 :penalty_tax => penalty_tax,
														 :interest => interest
												)
			redirect "/sessions/tax_details/#{@tax.client_id}"
		else
			redirect "/client/edit/wages/#{wage.client_id}"
		end

	end

	get '/client/delete/wages/:id/:year' do
		wage = Wage.find_by(:client_id => params[:id], :tax_year => params[:year])
		wage.destroy
		tax = Tax.find_by(:client_id => params[:id], :tax_year => params[:year])
		tax.destroy
		redirect "/client/edit/#{params[:id]}"
	end

end