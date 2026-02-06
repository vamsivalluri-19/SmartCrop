from fastapi import APIRouter

router = APIRouter()

@router.get("/")
def weather():
    return {
        "temperature": "30°C",
        "humidity": "70%"
    }
