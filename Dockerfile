FROM python:3.7

ENV FLASK_ENV docker

WORKDIR /app
COPY . .
RUN pip install --upgrade pip
RUN pip install --compile --no-cache-dir -r requirements.txt
EXPOSE 5000
ENTRYPOINT ["gunicorn", "-b", "0.0.0.0:5000", "app"]
