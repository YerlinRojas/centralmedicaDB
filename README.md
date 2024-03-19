# Documentación

# Desafío de Diseño: Sistema de Gestión Medica 👩🏽‍⚕️💻

## Problema
Nuestro equipo de desarrollo está inmerso en la creación de un sistema de gestión para calendarizar turnos medicos, especializandose en turnos de terapia psicologica, pudiendo crecer para otras especialidades medicas dentro del centro medico. Nos enfrentamos al emocionante desafío de diseñar una base de datos eficiente que maneje de manera óptima todas las operaciones relacionadas con la información de pacientes, médicos, citas, historias médicas y terapias.

## Descripción del Problema
1. **Gestión Integral de Pacientes y Medicos**:
   Necesitamos una base de datos que permita registrar de manera detallada la información de los pacientes que ingresan al centro médico, así como del personal médico involucrado en el proceso. Es fundamental diferenciar entre las diversas especialidades médicas ofrecidas en el centro para una gestión integral y efectiva.

2. **Gestión de turnos medicos y Disponibilidad Óptima**:
   La base de datos debe permitirnos registrar la disponibilidad de turnos médicos según la especialidad del médico, gestionar el ingreso de los pacientes y mantener actualizado el estado de los turnos médicos (ocupado o disponible). Esto garantizará una asignación eficiente entre turnos, médicos especialistas y pacientes, evitando conflictos y mejorando la atención al paciente.

3. **Privacidad y confidencialidad**
    Es crucial que los recursos de la base de datos sean manipulados únicamente según los roles correspondientes, asegurando la privacidad y confidencialidad de los datos tanto de los pacientes como de los médicos especialistas. Se debe implementar una capa de seguridad robusta para proteger la integridad de la información confidencial.

4. **Registro Detallado de las Historias Medicas**:
   El sistema debe registrar minuciosamente cada ingreso de paciente, incluyendo la fecha y hora, datos personales del paciente, médicos especialistas que lo atendieron y el registro de terapias realizadas. Este nivel de detalle nos permitirá llevar un control preciso de la evolución de cada paciente y mejorar la calidad de la atención médica.

5. **Registro Detallado de las Terapias**:
    Es fundamental mantener un registro detallado de cada terapia realizada, su gestión y seguimiento en relación con el paciente. Esto permitirá una optimización de los recursos médicos, ayudando a los médicos especialistas a obtener conclusiones más acertadas para sus pacientes y mejorar la calidad de vida de estos últimos.

## Entidades Principales

1. **Pacientes:**
    Cada paciente tiene un ID único, nombre, apellido, fecha de nacimiento, género, dirección y número de teléfono.

2. **Médicos:**
    Cada médico tiene un ID único, nombre, apellido, especialidad, número de teléfono y la sala en la que consulta.

3. **Citas:**
    Las citas están asociadas a un paciente y un médico específicos.
    Incluyen la fecha y hora de la cita.
    
4. **Disponibilidad de Médicos:**
    Registra la disponibilidad de los médicos para citas.
    Incluye la fecha, hora, estado (ocupado/disponible) y comentarios adicionales.

5. **Historias Médicas:**
    Cada historial médico tiene un ID único, paciente asociado, médico a cargo, fecha de concurrencia, detalles de la visita, diagnóstico y tratamiento.

6. **Terapias:**
    Las terapias están asociadas a un paciente y un médico.
    Cada terapia incluye una fecha de sesión, detalles de la sesión, progreso y observaciones.

## Objetivo
El objetivo principal es crear una base de datos que permita a un centro médico gestionar de manera efectiva la información de pacientes, médicos, citas, historias médicas y terapias. Esta base de datos debe ser fácil de mantener, escalable y garantizar la integridad de los datos, permitiendo así una gestión ágil y precisa de todas las operaciones médicas.


## Diagrama Entidad Relación

![diagrama entidad relacion](../centralmedicaDB/public/images/DiagramaEntidadRelacion.png)