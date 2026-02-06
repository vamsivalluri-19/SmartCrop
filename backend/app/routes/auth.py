from fastapi import APIRouter

router = APIRouter()

@router.post("/login")
def login():
    return {"message": "Login API working"}

@router.post("/register")
def register():
    return {"message": "Register API working"}
