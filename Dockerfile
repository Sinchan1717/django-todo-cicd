# Use a stable Python version
FROM python:3.11

# Set the working directory inside the container
WORKDIR /data

# Install system dependencies to ensure distutils is available
RUN apt-get update && apt-get install -y python3-distutils python3-pip

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Install Django version 3.2
RUN pip install django==3.2

# Copy all files from the current directory into the container's /data directory
COPY . .

# Run Django migrations
RUN python manage.py migrate

# Expose the port on which Django will run
EXPOSE 8000

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
