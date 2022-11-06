from typing import Tuple, Optional

import psycopg2

from api.business_logic.exc import DbConnectionError, SQLError


class DbDriver:
    """
    Interface between db and project. All interactions/operations with db
    are performed through this class.
    """
    
    def __init__(self, connection_string: str) -> None:
        self.connection_string = connection_string
        self.connection: Optional[psycopg2.connection] = None
    
    def execute(self, query: str, values: Tuple = (), fetch: bool = True):
        conn = self._get_connection()
        crsr = conn.cursor()
        try:
            crsr.execute(query, values)
            if fetch:
                result = crsr.fetchall()
                return result
        except Exception as e:
            raise SQLError(e)
        finally:
            self._close_connection()

    def _get_connection(self) -> psycopg2.connection:
        if self.connection_string is None:
            raise DbConnectionError("Missing connection string.")
        try:
            conn = psycopg2.connect(self.connection_string)
            return conn
        except Exception as e:
            raise DbConnectionError(e)

    def _close_connection(self) -> None:
        if self.connection is not None:
            self.connection.close()

