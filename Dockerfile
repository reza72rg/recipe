# Use a lightweight Python image
FROM python:3.9-alpine3.13

# Set the maintainer label
LABEL maintainer="reza72rg@gmail.com"

# Environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/py/bin:$PATH"

# Copy and install dependencies
COPY ./requirements.txt /tmp/requirements.txt
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --no-cache gcc musl-dev libffi-dev openssl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    apk del gcc musl-dev libffi-dev openssl-dev && \
    rm -rf /tmp

# Add a non-root user
RUN adduser \
    --disabled-password \
    --no-create-home \
    django-adduser

# Copy application code
COPY ./app /app

# Set work directory and permissions
WORKDIR /app
RUN chown -R django-adduser:django-adduser /app

# Expose the application port
EXPOSE 8000

# Switch to non-root user
USER django-adduser
