import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from app.routes import auth, crop, weather, dashboard

app = FastAPI(title="SmartCrop API")

# Enable CORS for frontend interaction
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include API Routers
app.include_router(auth.router, prefix="/api/auth", tags=["Auth"])
app.include_router(crop.router, prefix="/api/crop", tags=["Crop"])
app.include_router(weather.router, prefix="/api/weather", tags=["Weather"])
app.include_router(dashboard.router, prefix="/api/dashboard", tags=["Dashboard"])

# Directory configuration for static files
# Resolves the path to the root folder (where index.html is)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# Serve CSS and JS folders specifically
app.mount("/css", StaticFiles(directory=os.path.join(BASE_DIR, "css")), name="css")
app.mount("/js", StaticFiles(directory=os.path.join(BASE_DIR, "js")), name="js")

# Mount the root directory to serve HTML files (index.html, etc.)
app.mount("/", StaticFiles(directory=BASE_DIR, html=True), name="frontend")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)