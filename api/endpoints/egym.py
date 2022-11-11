from fastapi import FastAPI
from fastapi import HTTPException

from api.business_logic.DTOs import TrainerProfile, TraineeProfile
from api.providers.factory import ProvidersFactory
from api.business_logic.exc import DbConnectionError, SQLError


app = FastAPI(docs_url="/swagger")

@app.post("/write_trainer")
def write_trainer(user: TrainerProfile):
    provider = ProvidersFactory.get_users_provider()
    try:
        provider.write_trainer(user)
    except (DbConnectionError, SQLError) as e:
        print(e)
        raise HTTPException(status_code=503, detail=str(e))

@app.post("/write_trainee")
def write_trainee(user: TraineeProfile):
    provider = ProvidersFactory.get_users_provider()
    try:
        provider.write_trainee(user)
    except (DbConnectionError, SQLError) as e:
        print(e)
        raise HTTPException(status_code=503, detail=str(e))
