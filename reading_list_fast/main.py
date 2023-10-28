from fastapi import FastAPI 
from fastapi.middleware.cors import CORSMiddleware
from database import engine
import models
from routers import auth, book,user

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"], 
)

models.Base.metadata.create_all(bind=engine)

app.include_router(auth.router)
app.include_router(user.router)
app.include_router(book.router)