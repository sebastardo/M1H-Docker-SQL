docker build -t taxi_trips_zones:v001 .

docker run -it \
  -v $(pwd)/data:/data \
  --network=tarea_default \
  taxi_trips_zones:v001 \
  --host=postgres \
  --port=5432
