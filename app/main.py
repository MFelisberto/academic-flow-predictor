from fastapi import FastAPI

app = FastAPI(title="Academic Flow Predictor", description="API para predição de fluxo discente")

@app.get("/")
def read_root():
    return {"status": "sucesso", "mensagem": "API rodando perfeitamente!"}