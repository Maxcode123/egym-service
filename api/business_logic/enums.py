from enum import Enum


class Sex(str, Enum):
    MALE = "M"
    FEMALE = "F"


class TrainerType(Enum):
    FREELANCER = 1
    GYM = 2


class Env(Enum):
    PROD = 1
    DEV = 2
    LOCAL = 3