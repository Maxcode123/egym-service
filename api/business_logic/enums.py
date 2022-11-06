from enum import Enum

class Sex(str, Enum):
    MALE = "M"
    FEMALE = "F"


class TrainerType(Enum):
    FREELANCER = 1
    GYM = 2