import uvicorn

from api.endpoints.egym import app

if __name__ == "__main__":
    uvicorn.run(app, port=24550)