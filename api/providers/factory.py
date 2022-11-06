from api.providers.db_driver import DbDriver
from api.providers.users_provider import UsersProvider
from api.configuration.config_loader import ConfigLoader


class ProvidersFactory:
    """
    Constructs providers.
    All providers should be instantiated through this class.
    """

    @classmethod
    def get_users_provider(cls) -> UsersProvider:
        return UsersProvider(cls._get_db_driver())
    
    @staticmethod
    def _get_db_driver() -> DbDriver:
        return DbDriver(ConfigLoader.load_config().connection_string)