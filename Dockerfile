# Use the official Python image as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy your Python application files into the container
COPY ./python-app /app

# Install any dependencies your application needs
RUN pip install -r requirements.txt

# Expose the port your web application will listen on (e.g., 5000)
EXPOSE 5000

# Specify the command to run your Python web application
CMD ["python", "./app.py"]
