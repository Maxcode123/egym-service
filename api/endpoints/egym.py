from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from api.business_logic.DTOs import TrainerProfile, TraineeProfile
from api.providers.factory import ProvidersFactory
from api.business_logic.exc import DbConnectionError, SQLError


app = FastAPI(docs_url="/swagger")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


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
