import json
from dataclasses import dataclass
from typing import Dict, Any


@dataclass
class Config:
    connection_string: str


class ConfigLoader:
    """
    Responsible for loading the configuration file. Configuration settings are
    accessed through the object returned from load_config method.
    """
    
    @classmethod
    def load_config(cls) -> Config:
        with open() as f:
            json_conf = json.load(f)
        conf = cls._create_config(json_conf)
        return conf
    
    @staticmethod
    def _create_config(json_conf: Dict[str, Any]) -> Config:
        return Config(**json_conf)