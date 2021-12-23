class Admin::AppointmentsController < Admin::BaseController
  before_action :set_appointment, only: [:show, :edit, :update,:destroy]

  def index
    @appointments = policy_scope(Appointment)
  end

  def show
    authorize @appointment
  end

  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  def edit
    authorize @appointment
  end

  def create
    @appointment = Appointment.new(appointment_params)
    authorize @appointment
    if @appointment.save
      flash[:success] = t('messages.created', model: @appointment.class.model_name.human)
      redirect_to [:admin, @appointment]
    else      
      render :new
    end
  end

  def update
    authorize @appointment
    if @appointment.update(appointment_params)
      flash[:success] = t('messages.updated', model: @appointment.class.model_name.human)
      redirect_to [:admin, @appointment]
    else      
      render :edit
    end
  end

  def destroy
    authorize @appointment
    @appointment.destroy
    flash[:success] = t('messages.deleted', model: @appointment.class.model_name.human)
    redirect_to admin_appointments_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def appointment_params
      params.require(:appointment).permit(:doctor_id, :patient_id, :appointment_date)
    end
end
