require 'rails_helper'

describe AppointmentsController do

  let(:doctor) { create(:doctor) }
  let(:patient) { create(:patient) }
  let(:valid_attributes) { attributes_for :appointment, doctor_id: doctor.id, patient_id: patient.id }

  let(:invalid_attributes) { attributes_for :appointment, doctor_id: doctor.id, patient_id: patient.id, start_time: 1.day.ago }

  let(:valid_session) { {} }

  describe "GET #index" do
    let!(:appointment) { create :appointment }
    it "assigns all appointments as @appointments" do
      get :index, {}, valid_session
      expect(assigns(:appointments)).to eq([appointment])
    end
  end

  describe "GET #show" do
    let!(:appointment) { create(:appointment) }
    it "assigns the requested appointment as @appointment" do
      get :show, {:id => appointment.to_param}, valid_session
      expect(assigns(:appointment)).to eq(appointment)
    end
  end

  describe "Get #book" do
    let!(:patient) { create :patient }
    it "assigns a new appointment as @appointment" do
      get :book, {:patient_id => patient.id}, valid_session
      expect(assigns(:appointment)).to be_a_new(Appointment)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Appointment" do
        expect {
          post :create, {:appointment => valid_attributes}, valid_session
        }.to change(Appointment, :count).by(1)
      end

      it "assigns a newly created appointment as @appointment" do
        post :create, {:appointment => valid_attributes}, valid_session
        expect(assigns(:appointment)).to be_a(Appointment)
        expect(assigns(:appointment)).to be_persisted
      end

      it "redirects to the created appointment" do
        post :create, {:appointment => valid_attributes}, valid_session
        expect(response).to redirect_to(Appointment.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved appointment as @appointment" do
        post :create, {:appointment => invalid_attributes}, valid_session
        expect(assigns(:appointment)).to be_a_new(Appointment)
      end

      it "re-renders the 'book' template" do
        post :create, {:appointment => invalid_attributes}, valid_session
        expect(response).to render_template("book")
      end
    end
  end
end
