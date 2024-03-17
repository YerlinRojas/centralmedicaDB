DROP DATABASE IF EXISTS centralmedical_db ;
CREATE DATABASE centralmedical_db;

USE centralmedical_db;


CREATE TABLE patients(
    id_patient INT  AUTO_INCREMENT PRIMARY KEY,
    firts_name VARCHAR(100),
    last_name VARCHAR(100),
    birth DATE,
    gender VARCHAR(10),
    address VARCHAR(255),
    phone VARCHAR(20)
)
COMMENT "PATIENTS DATA"
;
CREATE TABLE doctors(
    id_doctor INT AUTO_INCREMENT PRIMARY KEY,
    firts_name VARCHAR(100),
    last_name VARCHAR(100),
    speciality VARCHAR(100),
    phone VARCHAR(20),
    room VARCHAR(100)
)
COMMENT "DOCTORS DATA"
;

CREATE TABLE appointments(
    id_appointment INT AUTO_INCREMENT PRIMARY KEY,
    id_patient INT,
    id_doctor INT,
    appointment_date DATE,
    appointment_time TIME
   )
   COMMENT "APPOINTMENTS DATA"
   ;
   
   
CREATE TABLE availabilityDate (
    id_availabilityDate INT AUTO_INCREMENT PRIMARY KEY,
    id_doctor INT,
    availability_date DATE,
    availability_time TIME,
    status VARCHAR(20),
    comment VARCHAR(255)
)
COMMENT "AVAILABILITY DATES"
;

CREATE TABLE medical_history (
    id_history INT AUTO_INCREMENT PRIMARY KEY,
    id_patient INT,
    id_doctor INT,
    concurrence_date DATE,
    details TEXT,
	diagnosis TEXT,
    treatment TEXT
 )
 COMMENT "MEDICAL HISTORY"
 ;


CREATE TABLE therapy(
	id_sesion BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    id_patient INT ,
    id_doctor INT,
    sesion_date DATE,
    details TEXT,
    progress TEXT,
    obs TEXT
    )
    COMMENT "THERAPY DATA"
    ;
    


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
REFERENCES availabilityDate(id_availabilityDate);

	

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
ADD CONSTRAINT fk_history_id_therapy
FOREIGN KEY (id_history)
REFERENCES medical_history(id_history);

