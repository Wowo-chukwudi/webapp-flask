#FROM ubuntu:20.04
#RUN apt-get update && apt-get install -y python3 python3-pip
#RUN pip3 install flask
#COPY app.py /opt/
#ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080




# I used an Alpine-based Python image for smaller image size and to reduce attack surface
FROM python:3.13-rc-alpine3.20

# Set the working directory inside the container
WORKDIR /opt

# There's no need for apt-get on Alpine so I installed Flask directly; 
RUN pip install --no-cache-dir flask

# Copy the application code into the container
COPY app.py .

# Create a non-root user and set permissions to enable least privileged user
RUN addgroup -S myapp && adduser -S myapp -G myapp
RUN chown -R myapp:myapp /opt

# Switch to the non-root user
USER myapp

# Set the command to run the Flask application
CMD ["flask", "run", "--host=0.0.0.0", "--port=8080"]