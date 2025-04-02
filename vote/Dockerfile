FROM python:3.11
WORKDIR /app
COPY vote/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY vote/ .
CMD ["python", "app.py"]