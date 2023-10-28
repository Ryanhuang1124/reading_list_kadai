from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, Field
from starlette import status
from database import DB_ANNOTATED
from models import Books
from .auth import VERIFY_TOKEN


router = APIRouter(
    tags=['book'],
    prefix='/book'
)

class RequestDeleteBook(BaseModel):
    book_id : int
    class Config:
        json_schema_extra={
			'example':{
            'book_id':'book_id to be deleted'
			}
		}

class RequestBookTitle(BaseModel):
    title : str = Field(max_length=20) 
    part : str = Field(max_length=20) 
    author : str = Field(max_length=20) 
    publishing : str = Field(max_length=20) 
    memo : str = Field(max_length=20) 
    
    class Config:
        json_schema_extra={
			'example':{
            'title':'Title Of Book'
			}
		}



class ResponseBook(BaseModel):
    msg : str
    title : str
    book_id : int


class ResponseBooksList(BaseModel):
    msg : str
    book_list : list
    count : int



@router.get("/",status_code=status.HTTP_200_OK,response_model=ResponseBooksList)
def get_self_records(session : DB_ANNOTATED , applyer : VERIFY_TOKEN):
    user_id = applyer.get("id")
    
    data = [{"book_id":book.id , "title":book.title,"memo":book.memo,"publishing":book.publishing,"author":book.author,"part":book.part} for book in session.query(Books).filter( Books.user_id == user_id ).all()]
    
    return ResponseBooksList(msg="success",book_list=data,count=len(data))


@router.post("/create" ,status_code=status.HTTP_201_CREATED,response_model=ResponseBook)
async def create_self_book(session:DB_ANNOTATED, request_data : RequestBookTitle,applyer : VERIFY_TOKEN):

    user_id = applyer.get("id")


    data = Books( 
        title = request_data.title,
        part = request_data.part,
        author = request_data.author,
        publishing = request_data.publishing,
        memo = request_data.memo,
        user_id = user_id
    )
    session.add(data)
    session.commit()
    
    return ResponseBook(msg='Book Created',title=data.title,book_id = data.id)



@router.put("/edit_book",status_code=status.HTTP_202_ACCEPTED,response_model=ResponseBook)
async def edit_book_title_by_id(book_id:str,session:DB_ANNOTATED,request_data : RequestBookTitle,applyer : VERIFY_TOKEN):
    book = session.query(Books).filter(Books.id == book_id).first()
    user_id = applyer.get("id")

    
    if book is not None:
        if book.user_id == user_id:
            book.title = request_data.title
            book.part = request_data.part,
            book.author = request_data.author,
            book.publishing = request_data.publishing,
            book.memo = request_data.memo
            session.commit()
            return ResponseBook(msg='Book Updated',title=book.title,book_id = book.id)
        else:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,detail="Unauthorized")
    else:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,detail="Book Not Found")
        
    


@router.delete("/delete" ,status_code=status.HTTP_202_ACCEPTED,response_model=ResponseBook)
async def delete_book_by_id(book_id:str,session:DB_ANNOTATED,applyer : VERIFY_TOKEN):
    user_id = applyer.get("id")

    
    book = session.query(Books).filter(Books.id == book_id).first()
    if book is not None:
        if book.user_id == user_id:
            session.delete(book)
            session.commit()
            return ResponseBook(msg='Book Deleted',title=book.title,book_id = book.id)
        else:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,detail="Unauthorized")

    else:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,detail="Book Not Found")