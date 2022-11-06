from dataclasses import dataclass

from api.business_logic.enums import Sex, TrainerType


@dataclass
class User:
    email: str
    username: str
    password: str
    bank_account: int


@dataclass
class UserProfile:
    user: User
    name: str
    surname: str
    sex: Sex
    age: int
    country: str
    area: str
    phone_number: str


@dataclass
class TrainerProfile(UserProfile):
    trainer_type: TrainerType
    description: str


@dataclass
class TraineeProfile(UserProfile):
    weight: float  # kg
    height: int  # cm