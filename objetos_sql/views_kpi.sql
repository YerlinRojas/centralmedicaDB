
-- >>>>>>>>>>>>>>>>>>>>>> VIEWS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- VISTAS CITAS POR ESTADO
CREATE VIEW citas_por_estado AS
SELECT status, COUNT(*) AS cantidad_citas
FROM appointments
GROUP BY status;

SELECT * FROM citas_por_estado;

-- VISTA HISTORIAL MEDICO POR PACIENTE
CREATE VIEW historial_medico_por_paciente AS
SELECT p.first_name, p.last_name, mh.details, mh.diagnosis, mh.treatment
FROM patients p
JOIN medical_history mh ON p.id_patient = mh.id_patient;

SELECT * FROM historial_medico_por_paciente;


-- VISTA SE SESIONES MEDICO TERAPIA POR PACIENTE
CREATE VIEW sesiones_terapia_por_paciente AS
SELECT p.first_name, p.last_name, t.details, t.progress, t.obs
FROM patients p
JOIN therapy t ON p.id_patient = t.id_patient;

SELECT * FROM sesiones_terapia_por_paciente;



-- VISTA DISPONIBILIDAD DE DOCTORES
CREATE VIEW disponibilidad_doctores AS
SELECT d.first_name, d.last_name, ad.availability_date, ad.availability_time_from, ad.availability_time_to
FROM doctors d
JOIN availabilityDate ad ON d.id_doctor = ad.id_doctor;

SELECT * FROM disponibilidad_doctores;

-- VISTA FRECUENCIA DE DIAGNOSTICOS
CREATE VIEW frecuencia_diagnosticos AS
SELECT d.speciality, mh.diagnosis, COUNT(*) AS cantidad_diagnosticos
FROM doctors d
JOIN medical_history mh ON d.id_doctor = mh.id_doctor
GROUP BY d.speciality, mh.diagnosis;
SELECT * FROM  frecuencia_diagnosticos;
