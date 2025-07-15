-- ================================================
-- Main table definitions
-- ================================================

-- Student table
CREATE TABLE Student (
    id              NUMBER PRIMARY KEY,
    StudentID       VARCHAR2(15) UNIQUE,
    FirstName       VARCHAR2(100 CHAR),
    LastName        VARCHAR2(150 CHAR),
    Gender          VARCHAR2(10),
    Phone           VARCHAR2(20),
    Address         VARCHAR2(255),
    Email           VARCHAR(100),
    BirthDay        DATE,
    NationalId      VARCHAR2(10) UNIQUE,
    Nationality     VARCHAR(40),
    Grade           NUMBER,
    Registery_Year  VARCHAR2(4)
);

-- Teacher table
CREATE TABLE Teacher (
    id             NUMBER PRIMARY KEY,
    TeacherID      VARCHAR2(10) UNIQUE,
    FirstName      VARCHAR2(100),
    LastName       VARCHAR2(100),
    Gender         VARCHAR2(10),
    Address        VARCHAR2(255),
    Phone          VARCHAR2(20),
    Email          VARCHAR2(100),
    BirthDay       DATE,
    NationalId     VARCHAR2(10) UNIQUE,
    Nationality    VARCHAR2(40),
    EmploymentYear NUMBER
);

-- Counter per EmploymentYear for TeacherID generation
CREATE TABLE Teacher_Counter (
    EmploymentYear NUMBER PRIMARY KEY,
    Counter        NUMBER
);

-- Subjects assigned to teachers
CREATE TABLE Teacher_Subject (
    id           NUMBER PRIMARY KEY,
    TeacherID    VARCHAR2(10),
    Subject      VARCHAR2(50),
    GradeLevel   NUMBER CHECK (GradeLevel BETWEEN 10 AND 12),

    CONSTRAINT fk_teacher_subject 
        FOREIGN KEY (TeacherID)
        REFERENCES Teacher(TeacherID)
        ON DELETE CASCADE
);

-- Courses definition
CREATE TABLE Course (
    id          NUMBER PRIMARY KEY,
    title       VARCHAR2(100) NOT NULL,
    gradeLevel  NUMBER CHECK (gradeLevel BETWEEN 10 AND 12)
);

-- Link between Courses and Teachers (many-to-many)
CREATE TABLE Course_Teacher (
    course_id   NUMBER,
    teacher_id  NUMBER,
    PRIMARY KEY (course_id, teacher_id),

    CONSTRAINT fk_ct_course FOREIGN KEY (course_id)
        REFERENCES Course(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_ct_teacher FOREIGN KEY (teacher_id)
        REFERENCES Teacher(id)
        ON DELETE CASCADE
);

-- Grade report per student for each academic year
CREATE TABLE GradeReport (
    id             NUMBER PRIMARY KEY,
    student_id     VARCHAR2(15),
    grade_level    NUMBER CHECK (grade_level BETWEEN 10 AND 12),
    status         VARCHAR2(20) CHECK (status IN ('PASSED', 'FAILED', 'INCOMPLETE')),
    is_finalized   CHAR(1) CHECK (is_finalized IN ('Y', 'N')),

    CONSTRAINT fk_gr_student FOREIGN KEY (student_id)
        REFERENCES Student(StudentID)
        ON DELETE CASCADE
);

-- Per-course grades per grade report
CREATE TABLE Course_Grade (
    id            NUMBER PRIMARY KEY,
    grade_id      NUMBER,
    course_id     NUMBER,
    score         NUMBER(4,2) CHECK (score BETWEEN 0 AND 20),

    CONSTRAINT fk_course_grade_grade FOREIGN KEY (grade_id)
        REFERENCES GradeReport(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_course_grade_course FOREIGN KEY (course_id)
        REFERENCES Course(id)
        ON DELETE CASCADE
);
