FROM python:3.14.0a4

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed dependencies specified in requirements.txt
RUN pip install -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

ENV FLASK_APP=employees.py

# Define the command to run your application
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]