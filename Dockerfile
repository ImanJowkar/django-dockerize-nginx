# pull official base image
FROM python:3.11.4-slim-buster

# set work directory
ENV HOME=/home/app
RUN mkdir -p /home/app
ENV APP_HOME=/home/app/web
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/staticfiles
WORKDIR $APP_HOME


# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apt-get update && apt-get install -y netcat

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy entrypoint.sh
COPY ./entrypoint.sh .
RUN chmod +777 /home/app/web/entrypoint.sh

# copy project
COPY . .

# run entrypoint.sh
ENTRYPOINT ["sh", "entrypoint.sh"]