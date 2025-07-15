-- ================================================
-- Trigger to generate StudentID and ID
-- ================================================
CREATE OR REPLACE TRIGGER Studentid_trg
BEFORE INSERT ON Student
FOR EACH ROW
DECLARE
    persian_year VARCHAR2(4);
    seq_part     VARCHAR2(6);
BEGIN
    SELECT TO_CHAR(SYSDATE, 'YYYY', 'NLS_CALENDAR = PERSIAN')
    INTO persian_year FROM dual;

    seq_part := LPAD(TO_CHAR(Student_Id_Seq.NEXTVAL), 5, '0');
    :NEW.StudentID := persian_year || seq_part;
    :NEW.id := St_Id_Seq.NEXTVAL;

    IF :NEW.Registery_Year IS NULL THEN
        :NEW.Registery_Year := persian_year;
    END IF;
END;
/
-- ================================================
-- Trigger to generate TeacherID based on EmploymentYear
-- ================================================
CREATE OR REPLACE TRIGGER Teacherid_trg
BEFORE INSERT ON Teacher
FOR EACH ROW
DECLARE
    counter_num NUMBER;
BEGIN
    BEGIN
        INSERT INTO Teacher_Counter (EmploymentYear, Counter)
        VALUES (:NEW.EmploymentYear, 1);
        counter_num := 1;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE Teacher_Counter
            SET Counter = Counter + 1
            WHERE EmploymentYear = :NEW.EmploymentYear;

            SELECT Counter INTO counter_num
            FROM Teacher_Counter
            WHERE EmploymentYear = :NEW.EmploymentYear;
    END;

    :NEW.TeacherID := TO_CHAR(:NEW.EmploymentYear) || LPAD(counter_num, 3, '0');
    :NEW.id := Teacher_seq.NEXTVAL;
END;
/
