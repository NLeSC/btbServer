FROM mkuzak/flask

RUN mkdir /app
WORKDIR /app

COPY * ./
RUN apt-get install build-essential
RUN pip install -r requirements.txt

CMD python btbFlaskServer.py
