class ViewingPartyController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def new
    @facade = MovieFacade.new(nil, params[:movie_id])
    @user = User.find(params[:user_id])
  end

  def create
    party = ViewingParty.new(party_params)
    guest_emails = [params[:guest_1_email], params[:guest_2_email], params[:guest_3_email]]
    guests = guest_emails.map { |email| User.find_by(email: email) }.compact

    if party.save
      party.user_parties.create(user_id: params[:user_id], host: true)
      guests.each { |guest| party.user_parties.create(user_id: guest.id, host: false) }

      flash[:success] = "Viewing party successfully created!"
      redirect_to user_path(params[:user_id])
    else
      flash[:error] = "#{error_message(party.errors)}"
      redirect_to new_user_movie_viewing_party_path(params[:user_id], party.movie_id)
    end
  end

  def show
    @facade = MovieFacade.new(nil, params[:movie_id])
  end

  private
    def party_params
      params.permit(:duration, :date, :start_time, :movie_id, :party_id)
    end

    def require_user
      if !current_user
        flash[:error] = 'You must be logged in or registered to view this page'
        redirect_to user_movie_path(params[:user_id], params[:movie_id])
      end
    end
end