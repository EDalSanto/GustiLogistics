class PurchaseImportsController < ApplicationController
  include Importable
  before_action :check_valid_file_present, only: :create
  before_action :check_valid_filename, only: :create

  def new
    @purchase_import = PurchaseImport.new
  end

  def create
    @purchase_import = PurchaseImport.new(import_params)
    if @purchase_import.save
      redirect_to root_url, notice: "Imported Items Sold to Customers Report successfully."
    else
      render :new
    end
  end
 
  private

    def import_params
      params.require(:purchase_import).permit(:file)
    end
end
