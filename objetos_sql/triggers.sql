
-- >>>>>>>>>>>>>>>>>>>>>> TRIGGERS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- VERIFICA SI EL EMAIL YA SE ENCUENTRA REGISTRADO Y LANZA UN ERROR 
DROP TRIGGER IF EXISTS before_insert_patient_email_check;
DELIMITER //

CREATE TRIGGER before_insert_patient_email_check
BEFORE INSERT ON patients
FOR EACH ROW
BEGIN
    DECLARE email_count INT;

    
    SELECT COUNT(*) INTO email_count
    FROM patients
    WHERE email = NEW.email;

    
    IF email_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ya existe un paciente registrado con este email.';
    END IF;
END //

DELIMITER ;


-- ACTUALIZA LA DISPONIBILIDAD DE CADA APPOIMENTS Y LO ACTUALIZA SI SE LLEGA A CANCELAR COMPLETAR O CONFIRMAR
DROP TRIGGER IF EXISTS UpdateAvailabilityOnDeleteAppointment;
DELIMITER //

CREATE TRIGGER UpdateAvailabilityOnDeleteAppointment
BEFORE DELETE ON appointments
FOR EACH ROW
BEGIN
    DECLARE appointment_status ENUM('Pending', 'Confirmed', 'Cancelled', 'Completed');
    
    -- Obtener el estado de la cita que se va a eliminar
    SELECT status INTO appointment_status
    FROM appointments
    WHERE id_appointment = OLD.id_appointment;

    
    IF appointment_status = 'Confirmed' THEN
        
        UPDATE availabilityDate
        SET status = 'Available'
        WHERE id_doctor = OLD.id_doctor
            AND availability_date = OLD.appointment_date
            AND availability_time_from <= OLD.appointment_time
            AND availability_time_to > OLD.appointment_time;
    END IF;
END //

DELIMITER ;
