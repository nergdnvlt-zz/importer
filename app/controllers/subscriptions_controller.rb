class SubscriptionsController < ApplicationController
  before_action :set_company, only: %i[index destroy]
  before_action :set_subs, only: %i[index destroy]
  
  def index
    @subs
    respond_to do |format|
      format.html
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=#{@company.name}-active-subs.csv"
      end
    end
  end

  def destroy
    if @company.subscriptions.destroy_all
      redirect_to company_path(@company)
    else
      redirect_to company_subscriptions_path(@company)
    end
  end

  private

  def set_company
    @company = Company.find_by(name: params[:company_id])
  end

  def set_subs
    @subs ||= @company.subscriptions
  end
end
