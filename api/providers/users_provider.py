from api.providers.db_driver import DbDriver
from api.business_logic.DTOs import (
    TrainerProfile,
    TraineeProfile,
)


class UsersProvider:
    """
    Responsible for providing users, i.e. Trainers and Trainees, from db
    and for writing users into db.
    """
    def __init__(self, db_driver: DbDriver) -> None:
        self.db_driver = db_driver

    def get_trainer(self, email: str) -> TrainerProfile:
        pass

    def get_trainee(self, email: str) -> TraineeProfile:
        pass

    def write_trainer(self, trainer: TrainerProfile) -> None:
        query = """
        WITH
            TrainerData (TypeId, Description) AS (
                VALUES (%s, %s)
            ),
            _Users AS (
                INSERT INTO Users (
                    Name, Surname, Sex, Age, Email, Username, Password, Country,
                    Area, PhoneNumber
                    ) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING UserId
            )
        INSERT INTO Trainers (
            UserId, TrainerTypeId, ProfileDescription
        )
        SELECT _U.UserId, TD.TypeId, TD.Description
        FROM _Users AS _U, TrainerData AS TD
        """
        values = (
            trainer.trainer_type,
            trainer.description,
            trainer.name,
            trainer.surname,
            trainer.sex,
            trainer.age,
            trainer.user.email,
            trainer.user.username,
            trainer.user.password,
            trainer.country,
            trainer.area,
            trainer.phone_number,
        )
        self.db_driver.execute(query, values=values, fetch=False)


    def write_trainee(self, trainee: TraineeProfile) -> None:
        query = """
        WITH
            TraineeData (Weight, Height) AS (
                VALUES (%s, %s)
            ),
            _Users AS (
                INSERT INTO Users (
                    Name, Surname, Sex, Age, Email, Username, Password, Country,
                    Area, PhoneNumber
                    ) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING UserId
            )
        INSERT INTO Trainees (
            UserId, Weight, Height
        )
        SELECT _U.UserId, TD.Weight, TD.Height
        FROM _Users AS _U, TraineeData AS TD
        """
        values = (
            trainee.weight,
            trainee.height,
            trainee.name,
            trainee.surname,
            trainee.sex,
            trainee.age,
            trainee.user.email,
            trainee.user.username,
            trainee.user.password,
            trainee.country,
            trainee.area,
            trainee.phone_number,
        )
        self.db_driver.execute(query, values=values, fetch=False)
