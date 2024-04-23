-- >>>>>>>>>>>>>>>>>>>>>> FUNCTIONS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- CANTIDAD DE HORAS DE TERAPIA POR PACIENTE
DROP FUNCTION IF EXISTS CalculateTotalTherapyHoursByPatient;
DELIMITER //

CREATE FUNCTION CalculateTotalTherapyHoursByPatient(
    p_id_patient INT
)
RETURNS VARCHAR(20)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_hours DECIMAL(10,2) DEFAULT 0.0;
    DECLARE total_hours_string VARCHAR(20);

    -- Calcular la suma de horas de terapia para un paciente específico
    SELECT COALESCE(SUM(TIME_TO_SEC(TIMEDIFF(end_time, start_time)) / 3600), 0.00)
    INTO total_hours
    FROM therapy
    WHERE id_patient = p_id_patient;

    -- Convertir el total de horas a un formato legible con unidades
    SET total_hours_string = CONCAT(FORMAT(total_hours, 2), ' hrs');

    RETURN total_hours_string;
END //

DELIMITER ;
-- CALL
SELECT CalculateTotalTherapyHoursByPatient(1) AS total_therapy_hours_for_patient_1;




-- DURACION TOTAL DE LAS CITAS CONFIRMADAS POR EL PACIENTE
DROP FUNCTION IF EXISTS CalculateTotalAppointmentHoursByPatient;
DELIMITER //

CREATE FUNCTION CalculateTotalAppointmentHoursByPatient(
    p_id_patient INT
)
RETURNS VARCHAR(20)
DETERMINISTIC
READS SQL DATA 
BEGIN
    DECLARE total_hours DECIMAL(10,2) DEFAULT 0.0;
    DECLARE total_hours_string VARCHAR(20);

    -- Verificar si el paciente tiene citas confirmadas
    SELECT COUNT(*)
    INTO total_hours
    FROM appointments
    WHERE id_patient = p_id_patient
    AND status = 'Confirmed';

    -- Si el paciente tiene citas confirmadas, calcular la suma de horas
    IF total_hours > 0 THEN
        SELECT SUM(TIME_TO_SEC(TIMEDIFF(end_hour, start_hour)) / 3600)
        INTO total_hours
        FROM appointments
        WHERE id_patient = p_id_patient
        AND status = 'Confirmed';
    END IF;

    -- Convertir el total de horas a un formato legible con unidades
    SET total_hours_string = CONCAT(total_hours, ' hrs');

    RETURN total_hours_string;
END //

DELIMITER ;

-- call
SELECT CalculateTotalAppointmentHoursByPatient(1) AS total_appointment_hours_for_patient_1;

-- -----------------------------------------------------

-- AGREGAR HORARIOS
DROP FUNCTION IF EXISTS AddAvailableDays;
DELIMITER //

CREATE FUNCTION AddAvailableDays(
    p_id_doctor INT,
    p_start_date DATE,
    p_end_date DATE,
    p_interval INT
)
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE temp_date DATE;
    DECLARE message VARCHAR(255);

    SET temp_date = p_start_date;

    WHILE temp_date <= p_end_date DO
        INSERT INTO availabilityDate (id_doctor, availability_date, availability_time_from, availability_time_to, status)
        VALUES (p_id_doctor, temp_date, '08:00:00', '17:00:00', 'Available');
        
        SET temp_date = DATE_ADD(p_start_date, INTERVAL i DAY);
        SET i = i + p_interval;
    END WHILE;

    SET message = CONCAT('Days added successfully for doctor ', CAST(p_id_doctor AS CHAR), ' from ', p_start_date, ' to ', p_end_date, ' with interval ', CAST(p_interval AS CHAR), ' days.');
    RETURN message;
END //

DELIMITER ;


-- CALL
SELECT AddAvailableDays(1, '2024-04-20', '2024-04-30', 2) AS message;

SELECT
* FROM CENTRALMEDICAL_DB.AVAILABILITYDATE;

