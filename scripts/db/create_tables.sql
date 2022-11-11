CREATE TABLE Users (
    UserId SERIAL,
    Name VARCHAR(45),
    Surname VARCHAR(45),
    Sex CHARACTER(1),
    Age INTEGER,
    Email VARCHAR(60) UNIQUE,
    Username VARCHAR(30),
    Password VARCHAR(45),
    Country VARCHAR(30),
    Area VARCHAR(30),
    PhoneNumber VARCHAR(30),
    CONSTRAINT Users_PK PRIMARY KEY (UserId)
);

CREATE TABLE Gear (
    GearId Serial,
    GearName VARCHAR(60),
    CONSTRAINT Gear_PK PRIMARY KEY (GearId)
);

CREATE TABLE UserGear (
    UserId INTEGER,
    GearId INTEGER,
    Description VARCHAR(250),
    CONSTRAINT UserGear_PK PRIMARY KEY (UserId, GearId),
    CONSTRAINT UserGear_FK1 FOREIGN KEY (UserId) REFERENCES Users,
    CONSTRAINT UserGear_FK2 FOREIGN KEY (GearId) REFERENCES Gear
);

CREATE TABLE TrainerTypes (
    TypeId INTEGER,
    Name VARCHAR(60),
    CONSTRAINT TrainerTypes_PK PRIMARY KEY (TypeId)
);

CREATE TABLE Trainers (
    UserId INTEGER,
    TrainerTypeId INTEGER,
    ProfileDescription VARCHAR(250),
    CONSTRAINT Trainers_PK PRIMARY KEY (UserId),
    CONSTRAINT Trainers_FK1 FOREIGN KEY (UserId) REFERENCES Users,
    CONSTRAINT Trainers_FK2 FOREIGN KEY (TrainerTypeId) REFERENCES TrainerTypes
);

CREATE TABLE TrainerExercises (
    TrainerExerciseId SERIAL,
    UserId INTEGER,
    Name VARCHAR(60),
    CONSTRAINT TrainerExercises_PK PRIMARY KEY (TrainerExerciseId),
    CONSTRAINT TrainerExercises_FK FOREIGN KEY (UserId) REFERENCES Trainers
);

CREATE TABLE Courses (
    CourseId SERIAL,
    TrainerId INTEGER,
    Description VARCHAR(60),
    Duration INTEGER,
    Price REAL,
    CONSTRAINT Courses_PK PRIMARY KEY (CourseId),
    CONSTRAINT Courses_FK FOREIGN KEY (TrainerId) REFERENCES Trainers
);

CREATE TABLE Trainees (
    UserId INTEGER,
    Weight REAL,
    Height REAL,
    CONSTRAINT Trainees_PK PRIMARY KEY (UserId),
    CONSTRAINT Trainees_FK FOREIGN KEY (UserId) REFERENCES Users
);

CREATE TABLE TrainersTrainees (
    TrainerId INTEGER,
    TraineeId INTEGER,
    CONSTRAINT TrainersTrainees_PK PRIMARY KEY (TrainerId, TraineeId),
    CONSTRAINT TrainersTrainees_FK1 FOREIGN KEY (TrainerId) REFERENCES Trainers,
    CONSTRAINT TrainersTrainees_FK2 FOREIGN KEY (TraineeId) REFERENCES Trainees
);

CREATE TABLE TraineeCourses (
    TraineeId INTEGER,
    CourseId INTEGER,
    CONSTRAINT TraineeCourses_PK PRIMARY KEY (TraineeId, CourseId),
    CONSTRAINT TraineeCourses_FK1 FOREIGN KEY (TraineeId) REFERENCES Trainees,
    CONSTRAINT TraineeCourses_FK2 FOREIGN KEY (CourseId) REFERENCES Courses
);

CREATE TABLE TraineeExercises (
    ExerciseId SERIAL,
    TraineeId INTEGER,
    TrainingDay SMALLINT,
    WeekId INTEGER,
    WeekName VARCHAR(60),
    TrainerExerciseId INTEGER,
    Sets INTEGER,
    Reps INTEGER,
    Weight REAL,
    Rest REAL,
    IsDone BIT(1),
    DateDone TIMESTAMP,
    CONSTRAINT TraineeExercises_PK PRIMARY KEY (ExerciseId),
    CONSTRAINT TraineeExercises_FK1 FOREIGN KEY (TraineeId) REFERENCES Trainees,
    CONSTRAINT TraineeExercises_FK2 FOREIGN KEY (TrainerExerciseId) REFERENCES TrainerExercises
);
