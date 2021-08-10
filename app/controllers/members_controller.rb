class MembersController < ApplicationController

  def index
    @members = Member.with_contact_number
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      flash[:notice] = "Member created Successfully"
      redirect_to members_path
    else
      flash[:error] = @member.errors.full_messages
      redirect_to new_member_path
    end
  end

  def show
    @member = Member.find(params[:id])
    @address = @member.addresses.first
  end

  def update
    @member = Member.find(params[:id])
    if !@member
      flash[:error] = "Member Not found"
      redirect_to members_path and return
    elsif @member.update(member_params)
      flash[:notice] = "Member Updated sucessfully"
    else
      flash[:error] = @member.errors.full_messages
    end
    redirect_to member_path(@member)
  end

  def destroy
    @member = Member.find(params[:id])
    if @member.delete
      flash[:notice] = "Member deleted Successfully"      
    else
      flash[:error] = @member.errors.full_messages
    end
    redirect_to members_path
  end

  def leader_board
    @top_members = Member.top_members(10)
  end

  private

  def member_params
    params.require(:member).permit(:first_name, :last_name, :user_name,:addresses_attributes => [:address1, :address2, :address3, :post_code, :phone_number, :id])
  end
end
