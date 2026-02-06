from fastapi import APIRouter

router = APIRouter()

@router.get("/")
def dashboard():
    return {
        "users": 120,
        "predictions": 450
    }
