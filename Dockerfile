FROM mkuzak/flask

RUN mkdir /app
WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y libblas-dev liblapack-dev libssl-dev build-essential gfortran
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

CMD python btbFlaskServer.py
