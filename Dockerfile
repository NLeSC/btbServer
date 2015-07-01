FROM mkuzak/flask

RUN pip install
RUN mkdir /app
WORKDIR /app

COPY * ./

CMD python btbFlaskServer.py
