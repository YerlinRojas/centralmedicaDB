DROP DATABASE IF EXISTS centralmedical_db ;
CREATE DATABASE centralmedical_db;

USE centralmedical_db;


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

CREATE TABLE appointments(
	id_appointment INT AUTO_INCREMENT PRIMARY KEY,
    id_patient INT,
    id_doctor INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Cancelled', 'Completed') DEFAULT 'Pending'
   )
   COMMENT "APPOINTMENTS DATA"
   ;
   
   
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
ADD CONSTRAINT fk_history_id_therapy
FOREIGN KEY (id_history)
REFERENCES medical_history(id_history);



-- INSERT

INSERT INTO patients(id_patient,
    first_name,
    last_name,
    email,
    birth,
    gender,
    address,
    phone)
    VALUES 

(2, 'Antonius', 'Marns', 'amarns1@cnet.com', '2021/03/17', 'Male', '35492 Marquette Street', '220-680-8900'),
(3, 'Luca', 'Mordue', 'lmordue2@theglobeandmail.com', '1976/02/05', 'Male', '77 Thierer Pass', '170-343-3205'),
(4, 'Pegeen', 'Shucksmith', 'pshucksmith3@csmonitor.com', '2003/07/28', 'Female', '56 Thackeray Way', '738-570-6313'),
(5, 'Cindie', 'Benedicto', 'cbenedicto4@smugmug.com', '1953/03/31', 'Female', '6132 Oak Court', '932-441-7917'),
(6, 'Riley', 'MacShane', 'rmacshane5@infoseek.co.jp', '1988/09/17', 'Male', '3 Memorial Circle', '265-144-6806'),
(7, 'Jordana', 'Fluck', 'jfluck6@hao123.com', '2018/09/04', 'Female', '06 Beilfuss Plaza', '635-742-7694'),
(8, 'Meara', 'Heeron', 'mheeron7@youtube.com', '1959/10/12', 'Female', '32930 Sundown Hill', '968-668-0138'),
(9, 'Francine', 'Baff', 'fbaff8@netscape.com', '2004/09/30', 'Female', '1 Quincy Trail', '708-938-5118'),
(10, 'Franky', 'Prandini', 'fprandini9@ameblo.jp', '1962/12/15', 'Male', '5 Ridge Oak Lane', '598-323-4803'),
(11, 'Vinni', 'Reucastle', 'vreucastlea@google.cn', '1964/04/17', 'Female', '80915 Buhler Alley', '129-354-4267'),
(12, 'Caren', 'Bengal', 'cbengalb@nps.gov', '2013/12/18', 'Female', '6228 Buhler Park', '452-170-6797'),
(13, 'Clementia', 'Delos', 'cdelosc@jiathis.com', '2006/02/12', 'Female', '23 Warbler Drive', '347-315-7380'),
(14, 'Dion', 'McKibbin', 'dmckibbind@slate.com', '2021/10/31', 'Male', '605 Meadow Ridge Place', '625-606-8888'),
(15, 'Arlin', 'Doutch', 'adoutche@about.com', '2010/06/04', 'Male', '5808 Ridgeway Road', '118-985-9759'),
(16, 'Oriana', 'Strete', 'ostretef@drupal.org', '1936/12/21', 'Female', '58914 Sachtjen Road', '415-624-2823'),
(17, 'Iolanthe', 'Keigher', 'ikeigherg@pinterest.com', '1966/05/26', 'Female', '6 Chive Alley', '302-540-6313'),
(18, 'Tymothy', 'Bellino', 'tbellinoh@acquirethisname.com', '1952/06/24', 'Male', '685 Schurz Street', '696-518-4446'),
(19, 'Edin', 'Ors', 'eorsi@prlog.org', '1974/06/14', 'Female', '6 Hauk Point', '453-329-8781'),
(20, 'Sutton', 'Folds', 'sfoldsj@nba.com', '1990/04/28', 'Male', '29 Homewood Lane', '537-577-9584');



INSERT INTO doctors(
id_doctor,
    first_name ,
    last_name ,
    email ,
    speciality ,
    phone ,
    room 
)
VALUES
(1, 'Kelsi', 'Louiset', 'klouiset0@people.com.cn','nutrition', '907-720-7327', 1),
(2, 'Ariana', 'Ollett', 'aollett1@rambler.ru', 'nutrition','480-856-0737', 2),
(3, 'Lorine', 'MacGettigen', 'lmacgettigen2@creativecommons.org', 'psychologist', '730-195-5586', 3),
(4, 'Radcliffe', 'Willshere', 'rwillshere3@xing.com', 'psychologist','757-848-1622', 4),
(5, 'Patsy', 'Surgison', 'psurgison4@angelfire.com','pulmonologist', '613-984-3535', 5),
(6, 'Ardath', 'Fernandes', 'afernandes5@freewebs.com','psychologist', '922-820-8737', 6);


INSERT INTO appointments(
	id_appointment,
    id_patient,
    id_doctor,
    appointment_date,
    appointment_time,
    status
   )
VALUES
-- date yyy-mm-dd
(1,1,5,'2023/05/14','15:40:00','Cancelled'),
(2,1,5,'2023/05/15','15:40:00','Cancelled'),
(3,5,5,'2024/05/15','15:50:00','Confirmed'),
(4,14,5,'2024/05/15','15:50:00','Confirmed')
;

INSERT INTO availabilityDate (
    id_availability_date,
    id_doctor,
    availability_date,
    availability_time_from,
    availability_time_to,
    status ,
    comment
    )
VALUES
(1,5,'2024/05/15','15:00:00','16:00:00','Booked','comentario'),
(2,5,'2024/05/15','16:00:00','17:00:00','Available','comentario'),
(3,5,'2024/05/15','17:00:00','18:00:00','Available','comentario');
   
   
INSERT INTO medical_history (
    id_history ,
    id_patient ,
    id_doctor ,
    concurrence_date ,
    details ,
    diagnosis,
    treatment 
 )
VALUES
(1,5,5,'2021/01/20','DETAILS','DIAGNOSIS','TREATMENT'),
(2,1,5,'2011/08/12','DETAILS','DIAGNOSIS','TREATMENT'),
(3,14,5,'2008/05/18','DETAILS','DIAGNOSIS','TREATMENT');


INSERT INTO therapy(
    id_patient,
    id_doctor,
    session_date,
    details,
    progress,
    obs
)
VALUES
(1, 1, '2024-03-25', 'Detalles de la sesión', 'Progreso de la sesión', 'Observaciones de la sesión');


