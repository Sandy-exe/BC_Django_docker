# Use the official Python 3.12 slim image
FROM python:3.12-slim-bullseye

# Prevent Python from writing .pyc files and enable unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Setting the working directory in the container
WORKDIR /app

# Install pipenv
RUN pip install --upgrade pip && pip install pipenv

# Copy Pipfile and Pipfile.lock to the container
COPY Pipfile Pipfile.lock ./

# Install project dependencies using pipenv
RUN pipenv install --system --deploy

# Copy the rest of the application code
COPY . .

# Change the working directory to BC_IPFS where manage.py is located
WORKDIR /app/BC_IPFS

EXPOSE 8000

# Set the command to run your application
CMD ["python", "manage.py","runserver","0.0.0.0:8000"]
