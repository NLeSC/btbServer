FROM mkuzak/flask

RUN mkdir /app
WORKDIR /app

COPY * ./
RUN pip install -r requirements.txt

CMD python btbFlaskServer.py
