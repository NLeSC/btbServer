FROM mkuzak/flask

RUN mkdir /app
WORKDIR /app

COPY * ./
RUN pip install

CMD python btbFlaskServer.py
