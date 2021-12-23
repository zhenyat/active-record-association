class Admin::DoctorsController < Admin::BaseController
  before_action :set_doctor, only: [:show, :edit, :update,:destroy]

  def index
    @doctors = policy_scope(Doctor)
  end

  def show
    authorize @doctor
  end

  def new
    @doctor = Doctor.new
    authorize @doctor
  end

  def edit
    authorize @doctor
  end

  def create
    @doctor = Doctor.new(doctor_params)
    authorize @doctor
    if @doctor.save
      flash[:success] = t('messages.created', model: @doctor.class.model_name.human)
      redirect_to [:admin, @doctor]
    else      
      render :new
    end
  end

  def update
    authorize @doctor
    if @doctor.update(doctor_params)
      flash[:success] = t('messages.updated', model: @doctor.class.model_name.human)
      redirect_to [:admin, @doctor]
    else      
      render :edit
    end
  end

  def destroy
    authorize @doctor
    @doctor.destroy
    flash[:success] = t('messages.deleted', model: @doctor.class.model_name.human)
    redirect_to admin_doctors_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def doctor_params
      params.require(:doctor).permit(:name)
    end
end
