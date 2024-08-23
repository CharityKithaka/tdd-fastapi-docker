# pull official base image
FROM python:3.12.1-slim-bookworm

# set working directory
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt ./

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apt-get update \
  && apt-get -y install netcat-traditional gcc postgresql \
  && apt-get clean

# add app
COPY . .

# add entrypoint.sh
COPY ./entrypoint.sh ./
RUN chmod +x ./entrypoint.sh

# run entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]



# Run the application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
