from fastapi import FastAPI
from routers import users

app = FastAPI(
    title="System API",
    description="API to manage System",
    version="0.1"
)

@app.get("/")
async def root():
    return {"message": "Hello World"}


app.include_router(users.router, prefix="/users", tags=["users"])
