from app import main


def test_ping(test_app):
    # Given we have a test app
    # when we send a get
    response = test_app.get("/ping")
    # then we should get a 200 response
    assert response.status_code == 200
    assert response.json() == {"environment": "dev", "ping": "pong!", "testing": True}
