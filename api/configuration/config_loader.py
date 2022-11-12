import os
import json
from dataclasses import dataclass
from typing import Optional

import boto3
from botocore.exceptions import ClientError

from api.business_logic.enums import Env
from api import ROOT


@dataclass
class Config:
    connection_string: str


class ConfigLoader:
    """
    Responsible for loading the configuration file. Configuration settings are
    accessed through the object returned from load_config method.
    """
    conf: Optional[Config] = None
    secret_name = "pg-db-2-secret"
    region_name = "us-east-1"

    @classmethod
    def load_config(cls) -> Config:
        if cls.conf is None:
            if os.getenv("ENVM") == Env.PROD:
                cls.conf = cls._get_secret_conf()
            else:
                cls.conf = cls._get_local_conf()
        return cls.conf
    
    @classmethod
    def _get_secret_conf(cls) -> Config:
        client = boto3.client(
            service_name="secretsmanager",
            region_name=cls.region_name,
            )
        try:
            response = client.get_secret_value(SecretId=cls.secret_name)
            secret = json.loads(response["SecretString"])
            conn_str = f"postgres://{secret['username']}:{secret['password']}@{secret['host']}:{secret['port']}/egym"
            return Config(connection_string=conn_str)       
        except ClientError as e:
            raise e

    @staticmethod
    def _get_local_conf() -> Config:
        with open(os.path.join(ROOT, "configuration", "conf.json")) as f:
            json_conf = json.load(f)
        return Config(**json_conf)