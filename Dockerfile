# Use Python 3.11 to avoid potential issues with Python 3.13
FROM python:3.11

# Set the working directory inside the container
WORKDIR /data

# Install system dependencies
RUN apt-get update -y && apt-get install -y python3-distutils python3-setuptools python3-pip

# Copy the requirements file first to leverage Docker caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of the project files
COPY . .

# Run Django migrations
RUN python manage.py migrate

# Expose the port your Django app will run on
EXPOSE 8000

# Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
