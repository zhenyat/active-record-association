class Admin::PatientsController < Admin::BaseController
  before_action :set_patient, only: [:show, :edit, :update,:destroy]

  def index
    @patients = policy_scope(Patient)
  end

  def show
    authorize @patient
  end

  def new
    @patient = Patient.new
    authorize @patient
  end

  def edit
    authorize @patient
  end

  def create
    @patient = Patient.new(patient_params)
    authorize @patient
    if @patient.save
      flash[:success] = t('messages.created', model: @patient.class.model_name.human)
      redirect_to [:admin, @patient]
    else      
      render :new
    end
  end

  def update
    authorize @patient
    if @patient.update(patient_params)
      flash[:success] = t('messages.updated', model: @patient.class.model_name.human)
      redirect_to [:admin, @patient]
    else      
      render :edit
    end
  end

  def destroy
    authorize @patient
    @patient.destroy
    flash[:success] = t('messages.deleted', model: @patient.class.model_name.human)
    redirect_to admin_patients_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def patient_params
      params.require(:patient).permit(:name)
    end
end
