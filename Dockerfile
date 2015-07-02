FROM mkuzak/flask

RUN mkdir /app
WORKDIR /app

COPY * ./
RUN pip install --upgrade pip
RUN apt-get update && apt-get install -y python-scipy python-numpy build-essential
RUN pip install -r requirements.txt

CMD python btbFlaskServer.py
