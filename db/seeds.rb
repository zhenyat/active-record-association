Doctor.create name: 'Johnson'
Doctor.create name: 'Nelson'
Doctor.create name: 'Brown'

Patient.create name: 'Zhenya'
Patient.create name: 'Dasha'
Patient.create name: 'Rada'
Patient.create name: 'Julia'

Appointment.create patient_id: 2, doctor_id: 1, appointment_date: DateTime.now + 5.days