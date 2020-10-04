from flask import Flask, render_template
import os

application = Flask(__name__)

alarm = os.getenv("MODE") != "PRODUCTION"
version = os.getenv("VERSION")

@application.route("/")
def index():
    return render_template("index.html", alarm=alarm, version=version)

@application.route("/hello")
def hello():
    return "Helo cloud gurus"


if __name__ == "__main__":
    application.run(host='0.0.0.0')

