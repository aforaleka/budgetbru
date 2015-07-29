class ExpendituresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @expenditures = Expenditure.all.order(purchase_date: :desc)
  end

  def new
      @expenditure = Expenditure.new
  end

  def create
    @expenditure = current_user.expenditures.build expenditure_params
    
    if @expenditure.save
      redirect_to @expenditure
    else
      render :new
    end
  end

  def show
    @expenditure = Expenditure.find(params[:id])
  end

  def edit
    @expenditure = Expenditure.find params[:id]
    verify_expenditure_owner
  end

  def update
    @expenditure = Expenditure.find params[:id]
    verify_expenditure_owner

    if @expenditure.update expenditure_params
      redirect_to expenditure_path(@expenditure)
    else
      render :edit
    end
  end

  def destroy
    @expenditure = Expenditure.find params[:id]
    if @expenditure.user = current_user
      @expenditure.destroy
      redirect_to expenditures_path
      flash.notice = "successfully deleted"
    else
      redirect_to expenditure_path
      flash.alert = "Invalid Permissions"
    end
  end

  private

    def verify_expenditure_owner
      if @expenditure.user != current_user
        redirect_to expenditures_path
      end
    end

    def expenditure_params
      params.require(:expenditure).permit(:name, :price, :quantity, :purchase_date)
    end
end
