from database import Base
from sqlalchemy import ForeignKey,Column,Integer,String,Boolean,DateTime
from datetime import datetime

class Users(Base):
    __tablename__ = "users"
    id = Column("id",Integer,primary_key=True,index=True)
    name = Column("name",String)
    account = Column("account",String)
    password = Column("password",String)
    # date = Column("date",DateTime,default=datetime.utcnow)


class Books(Base):
    __tablename__ = "books"
    id = Column("id",Integer,primary_key=True,index=True)
    user_id = Column("user_id",Integer,ForeignKey("users.id"))
    title = Column("title",String)
    part = Column("part",String)
    author = Column("author",String)
    publishing = Column("publishing",String)
    memo = Column("memo",String)