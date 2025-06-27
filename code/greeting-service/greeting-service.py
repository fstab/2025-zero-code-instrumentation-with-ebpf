from flask import Flask
import random

app = Flask(__name__)

greetings = ['Hello', 'Greetings', 'Hola', 'Servus']

@app.route("/greeting")
def greeting():
    return random.choice(greetings) + '\n'
