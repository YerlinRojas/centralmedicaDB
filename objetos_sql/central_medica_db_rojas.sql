DROP DATABASE IF EXISTS centralmedical_db ;
CREATE DATABASE centralmedical_db;

USE centralmedical_db;

DROP TABLE IF EXISTS patients;
CREATE TABLE patients(
	id_patient INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    birth DATE,
    gender VARCHAR(10),
    address VARCHAR(255),
    phone VARCHAR(20)
)
COMMENT "PATIENTS DATA"
;

DROP TABLE IF EXISTS doctors;
CREATE TABLE doctors(
    id_doctor INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    speciality VARCHAR(100),
    phone VARCHAR(20),
    room VARCHAR(100)
)
COMMENT "DOCTORS DATA"
;


DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments(
    id_appointment INT AUTO_INCREMENT PRIMARY KEY,
    id_patient INT,
    id_doctor INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    start_hour TIME NOT NULL,
    end_hour TIME NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Cancelled', 'Completed') DEFAULT 'Pending'
) COMMENT "APPOINTMENTS DATA";


DROP TABLE IF EXISTS availabilityDate;
CREATE TABLE availabilityDate (
    id_availability_date INT AUTO_INCREMENT PRIMARY KEY,
    id_doctor INT,
    availability_date DATE NOT NULL,
    availability_time_from TIME NOT NULL,
    availability_time_to TIME NOT NULL,
    status ENUM('Available', 'Booked', 'Cancelled') DEFAULT 'Available',
    comment VARCHAR(255)
    )
COMMENT "AVAILABILITY DATES"
;

DROP TABLE IF EXISTS medical_history;
CREATE TABLE medical_history (
    id_history INT AUTO_INCREMENT PRIMARY KEY,
    id_patient INT,
    id_doctor INT,
    concurrence_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT,
    diagnosis TEXT,
    treatment TEXT
 )
 COMMENT "MEDICAL HISTORY"
 ;

DROP TABLE IF EXISTS therapy;
CREATE TABLE therapy(
	id_session BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    id_patient INT,
    id_doctor INT,
    session_date DATE,
    details TEXT,
    progress TEXT,
    obs TEXT
    )
    COMMENT "THERAPY DATA"
    ;
    
-- PATIENTS
ALTER TABLE patients
ADD CONSTRAINT chk_gender CHECK (gender IN ('Male', 'Female', 'Other')),
ADD CONSTRAINT chk_email_format_patients CHECK (email LIKE '%_@__%.__%');

-- DOCTORS
ALTER TABLE doctors 
ADD CONSTRAINT chk_email_format_doctors CHECK (email LIKE '%_@__%.__%');


  -- APPOINMENTS  
ALTER TABLE appointments
ADD CONSTRAINT fk_patient_id
FOREIGN KEY (id_patient)
REFERENCES patients(id_patient);

ALTER TABLE appointments
ADD CONSTRAINT fk_doctor_id
FOREIGN KEY (id_doctor)
REFERENCES doctors(id_doctor);

ALTER TABLE appointments
ADD COLUMN id_availability INT,
ADD CONSTRAINT fk_availability_id
FOREIGN KEY (id_availability)
REFERENCES availabilityDate(id_availability_date);

	

	-- availabilityDate
ALTER TABLE availabilityDate
ADD CONSTRAINT fk_availability_doctor_id
FOREIGN KEY (id_doctor)
REFERENCES doctors(id_doctor); 

	-- MEDICAL HISTORY
ALTER TABLE medical_history
ADD CONSTRAINT fk_patient_id_medical
FOREIGN KEY (id_patient)
REFERENCES patients(id_patient);

ALTER TABLE medical_history
ADD CONSTRAINT fk_doctor_id_medical
FOREIGN KEY (id_doctor)
REFERENCES doctors(id_doctor);



	-- THERAPY
ALTER TABLE therapy
ADD CONSTRAINT fk_patient_id_therapy
FOREIGN KEY (id_patient)
REFERENCES patients(id_patient);

ALTER TABLE therapy
ADD CONSTRAINT fk_doctor_id_therapy
FOREIGN KEY (id_doctor)
REFERENCES doctors(id_doctor);

ALTER TABLE therapy
ADD COLUMN id_history INT,
ADD COLUMN start_time TIME,
ADD COLUMN end_time TIME,
ADD CONSTRAINT fk_history_id_therapy
FOREIGN KEY (id_history)
REFERENCES medical_history(id_history);









