from fastapi import FastAPI
from app.config.db import get_connection

app = FastAPI(title="Job Application Tracker")



@app.get("/")
def root():
    connection=get_connection()
    connection.close()
    return {"message": "database is connected successfully"
    }