from locust import FastHttpUser, task


class WebSiteUser(FastHttpUser):
    host = "http://localhost:8089"

    @task
    def index(self):
        self.client.get("/")
