FROM mkuzak/flask

RUN mkdir /app
WORKDIR /app

COPY * ./

CMD python btbFlaskServer.py
