FROM python:3.7-alpine as base

FROM base AS dependencies
COPY requirements.txt ./
RUN apk add --no-cache curl python3 pkgconfig python3-dev openssl-dev libffi-dev musl-dev make gcc
RUN pip install -r requirements.txt

# --- Release with Alpine ----
FROM base

ENV FLASK_DEBUG=1

# Create app directory
RUN mkdir /pyapp
WORKDIR /pyapp

COPY --from=dependencies /root/.cache /root/.cache
COPY requirements.txt ./

# Install app dependencies
RUN pip install -r requirements.txt
COPY app/ ./app
COPY run.py ./

#CMD ["flask", "run", "--host=0.0.0.0"]
CMD ["gunicorn", "--bind=0.0.0.0:8000", "--reload", "run"]
