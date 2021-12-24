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
    @patient.appointments.build.build_doctor
    # Lines below as alternative building 
    # @appointments = @patient.appointments.build
    # @doctor = @appointments.build_doctor
    authorize @patient
  end

  def edit
    authorize @patient
  end

  def create
    @patient = Patient.new(patient_params)
    authorize @patient

    # Unbuild empty Appointment
    if patient_params['appointments_attributes']['appointment_date'].nil?
      # No appointment without date, patient only!
      @patient.appointments.last.delete
    end

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

    def patient_params
      if 'DDDL' == 'DDDL'   #  'doctor' is selected from DDDL
        params.require(:patient).permit(:id, :name, appointments_attributes: [:id, :appointment_date, :doctor_id])#doctor_attributes: [:id, :name]] )
      else      # new 'doctor' is created with 'appointment' (for demo)
        params.require(:patient).permit(:id, :name, appointments_attributes: [:id, :appointment_date, :doctor_id, doctor_attributes: [:id, :name]] )
      end
    end
end
