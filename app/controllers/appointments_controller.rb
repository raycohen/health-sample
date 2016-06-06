class AppointmentsController < ApplicationController

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/book/:patient_id
  def book
    @patient = Patient.find(params[:patient_id])
    ailment = @patient.ailment
    @doctors = Doctor.for_ailment(ailment).near_patient(@patient, 10)
    @appointment = Appointment.new
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html {
          @patient = @appointment.patient
          ailment = @patient.ailment
          @doctors = Doctor.for_ailment(ailment).near_patient(@patient, 10)
          render :book
        }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:doctor_id, :patient_id, :start_time)
  end
end
