from fastapi import FastAPI

app = FastAPI(title="Job Application Tracker")



@app.get("/")
def root():
    return {"message": "Job Application Tracker API is running"}