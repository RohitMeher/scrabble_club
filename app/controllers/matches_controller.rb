class MatchesController < ApplicationController

  def new
    @match = Match.new
  end

  def create
    params = match_params

    if params[:player1_user_name] == params[:player2_user_name]
      flash[:error] = "Cannot add match between same members"
      redirect_to new_match_path and return
    end

    @member1 = Member.find_by(user_name: params[:player1_user_name])
    @member2 = Member.find_by(user_name: params[:player2_user_name])

    if !@member1 || !@member2
      flash[:error] = "Members with user name #{params[:player1_user_name]} and #{params[:player1_user_name]} is not found" unless @member1 && @member2
      flash[:error] = "Member with user name #{params[:player1_user_name]} is not found" unless @member1
      flash[:error] = "Member with user name #{params[:player2_user_name]} is not found" unless @member2
      redirect_to new_match_path and return
    end

    @match = Match.new(venue: params[:venue], start_date: params[:start_date])
    unless @match.save
      flash[:error] = @match.errors.full_messages
      redirect_to new_match_path and return
    end

    @participant1 = Participant.new(match_id: @match.id, member_id: @member1.id, score: params[:player1_score])
    @participant2 = Participant.new(match_id: @match.id, member_id: @member2.id, score: params[:player2_score])
    if @participant1.score > @participant2.score
      @participant1.status = Participant::Status::WIN
      @participant2.status = Participant::Status::LOSE
      @member1.wins += 1
    elsif @participant2.score > @participant1.score
      @participant1.status = Participant::Status::LOSE
      @participant2.status = Participant::Status::WIN
      @member2.wins += 1
    else
      @participant1.status = @participant2.status = Participant::Status::DRAW
    end

    if @participant1.save && @participant2.save
      @member1.matches_played += 1
      @member2.matches_played += 1
      @member1.save
      @member2.save
      flash[:notice] = "Match is Created Succesfully"
      redirect_to members_path and return
    else
      messages = @participant1.errors.full_messages
      messages += @participant2.errors.full_messages
      flash[:error] = messages
      redirect_to new_match_path and return
    end
  end

  private

  def match_params
    params.require(:match).permit(:venue, :start_date, :player1_user_name, :player1_score, :player2_user_name, :player2_score)
  end
end
