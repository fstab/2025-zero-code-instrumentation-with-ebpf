FROM python:3.13-slim

RUN pip3 install flask

COPY greeting-service.py /

CMD [ "python3", "-m" , "flask", "--app", "greeting-service", "run", "--host=0.0.0.0"]
