-- >>>>>>>>>>>>>>>>>>>>>> STORED PROCEDURES <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
DROP PROCEDURE IF EXISTS ScheduleAppointment;
DELIMITER //

CREATE PROCEDURE ScheduleAppointment(
    IN p_id_doctor INT,
    IN p_appointment_date DATE,
    IN p_appointment_time TIME,
    IN p_start_hour TIME,
    IN p_end_hour TIME,
    IN p_id_patient INT
)
BEGIN
    DECLARE availability_count INT;

    SELECT COUNT(*) INTO availability_count
    FROM availabilityDate
    WHERE id_doctor = p_id_doctor
        AND availability_date = p_appointment_date
        AND availability_time_from <= p_appointment_time
        AND availability_time_to > p_appointment_time
        AND status = 'Available';

    IF availability_count > 0 THEN
        INSERT INTO appointments (id_patient, id_doctor, appointment_date, appointment_time, start_hour, end_hour, status)
        VALUES (p_id_patient, p_id_doctor, p_appointment_date, p_appointment_time, p_start_hour, p_end_hour, 'Confirmed');

        UPDATE availabilityDate
        SET status = 'Booked'
        WHERE id_doctor = p_id_doctor
            AND availability_date = p_appointment_date
            AND availability_time_from <= p_appointment_time
            AND availability_time_to > p_appointment_time;

        SELECT 'Appointment scheduled successfully.' AS message;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Doctor not available at the specified date and time.';
    END IF;
END //

DELIMITER ;

-- CALL
CALL ScheduleAppointment(1, '2024-04-24', '10:00:00', '09:30:00', '11:00:00', 1);

