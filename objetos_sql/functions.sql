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


    SELECT COUNT(*)
    INTO total_hours
    FROM appointments
    WHERE id_patient = p_id_patient
    AND status = 'Confirmed';


    IF total_hours > 0 THEN
        SELECT SUM(TIME_TO_SEC(TIMEDIFF(end_hour, start_hour)) / 3600)
        INTO total_hours
        FROM appointments
        WHERE id_patient = p_id_patient
        AND status = 'Confirmed';
    END IF;

 
    SET total_hours_string = CONCAT(total_hours, ' hrs');

    RETURN total_hours_string;
END //

DELIMITER ;

-- call
SELECT CalculateTotalAppointmentHoursByPatient(1) AS total_appointment_hours_for_patient_1;





-- AGREGAR HORARIOS
/*DROP FUNCTION IF EXISTS AddAvailableDays;
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
*/

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
    DECLARE temp_date DATE;
    DECLARE temp_time TIME;
    DECLARE message VARCHAR(255);

    SET temp_date = p_start_date;

    WHILE temp_date <= p_end_date DO
        SET temp_time = '08:00:00';
        
        -- Agregar horarios con intervalo de una hora hasta las 17:00 horas
        WHILE temp_time <= '17:00:00' DO
            INSERT INTO availabilityDate (id_doctor, availability_date, availability_time_from, availability_time_to, status)
            VALUES (p_id_doctor, temp_date, temp_time, ADDTIME(temp_time, '01:00:00'), 'Available');
            
            SET temp_time = ADDTIME(temp_time, '01:00:00'); -- Sumar una hora al tiempo actual
        END WHILE;
        
        SET temp_date = DATE_ADD(temp_date, INTERVAL p_interval DAY); -- Sumar el intervalo de días
    END WHILE;

    SET message = CONCAT('Days added successfully for doctor ', CAST(p_id_doctor AS CHAR), ' from ', p_start_date, ' to ', p_end_date, ' with interval ', CAST(p_interval AS CHAR), ' days.');
    RETURN message;
END //

DELIMITER ;



-- CALL
SELECT AddAvailableDays(3, '2024-04-20', '2024-04-30', 1) AS message;

SELECT
* FROM CENTRALMEDICAL_DB.AVAILABILITYDATE;

