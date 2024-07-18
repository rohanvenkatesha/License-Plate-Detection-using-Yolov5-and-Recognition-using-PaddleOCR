from flask import Flask, render_template

app = Flask(__name__)

headings = ("License number", "Place name", "Timeslot")

@app.route("/")
def table():
    return render_template("index.html")