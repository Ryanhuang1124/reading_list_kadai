from typing import Annotated
from fastapi import Depends
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker,Session
from sqlalchemy.ext.declarative import declarative_base

#postgreSQL
SQLALCHEMY_DATABASE_URL = 'DB URL'

engine = create_engine( SQLALCHEMY_DATABASE_URL )
local_session = sessionmaker( autocommit=False, autoflush=False,bind = engine)
Base = declarative_base()

def get_db():
    db = local_session()
    try:
        yield db
    finally:
        db.close()

DB_ANNOTATED = Annotated[Session,Depends(get_db)]